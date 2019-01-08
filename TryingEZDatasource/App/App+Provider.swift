//
//  App+Provider.swift
//  TryingEZDatasource
//
//  Created by Dominic Rodriquez on 11/30/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit
import COGuide
import AwesomeWeaponModel

class AppProvider: Observable {
    
    typealias Element = AppProvider.Context
    typealias Action = Event
    
    var observers: [String : ObserverWrapper<AppProvider.Context, Action>] = [:]
    var value = AppProvider.Context()
    
    /*
        model.createStore()
     
     */
    
    enum Event {
        case didRequestWeaponList(ofType: AppProvider.Weapons)
        case loadWeaponList(into: UICollectionView)
    }
    
    struct Context {
        
        var isWaitingForWeaponsToLoad: Bool = false
        var weaponListInView: AppProvider.Weapons?
        
        var selectedWeaponDatasource: (UICollectionViewDataSource & UICollectionViewDelegate)? {
            guard let selectedWeaponList = weaponListInView else { return nil }
            switch selectedWeaponList {
            case .upgradable: return upgradableWeaponDatasource
            case .descriptionsOnly: return weaponInfoDatasource
            case .rerollable: return randomWeaponDatasourceWithRerollAction
            case .completelyRandom: return randomWeaponDatasource
            case .mixed: return mixedWeaponsDatasource
            }
        }
    }
    
    static var upgradableWeaponDatasource: StoreArrayDatasource<WeaponCell>?
    static var weaponInfoDatasource: StoreArrayDatasource<WeaponInfoCell>?
    static var randomWeaponDatasourceWithRerollAction: RandomRerollableWeaponsDatasource?
    static var randomWeaponDatasource: RandomWeaponsDatasource?
    static var mixedWeaponsDatasource: WeaponCombinationDatasource?
    
    init() {
        
    }
}

extension AppProvider {
    
    enum Weapons {
        case upgradable
        case descriptionsOnly
        case rerollable
        case completelyRandom
        case mixed
    }
    
    func update(with action: Event, from oldValue: Context) -> Context {
        
        // make a local copy so we can update the values
        var newValue = oldValue
        
        switch action {
            
        // MARK: Request switching to a new weapon list. This puts the context into a loading state until it resolves the new list
        case .didRequestWeaponList(let weaponType):
            
            // update the weapon list to reflect
            newValue.weaponListInView = weaponType
            
            // now we know what we want, and we have to wait until that gets resolved
            newValue.isWaitingForWeaponsToLoad = true
            
        // MARK: Load a weapon list into the provided collection view and resolve the loading state
        case .loadWeaponList(let collectionView):
            
            // if we haven't selected a weapon list, then there's nothing to load into the collectionView
            guard let selectedWeaponList = newValue.weaponListInView else { break }
            
            // create the appropriate datasource for the currently selected list with the collection view provided
            switch selectedWeaponList {
            case .descriptionsOnly:
                // This one's model driven, but that's it- no actions
                AppProvider.weaponInfoDatasource = AppProvider.weaponInfoDatasource ?? WeaponInfoCell.makeDatasource(backedBy: WeaponStore.weaponStore, for: collectionView)
            case .upgradable:
                AppProvider.upgradableWeaponDatasource = AppProvider.upgradableWeaponDatasource ?? WeaponCell.makeDatasource(backedBy: WeaponStore.weaponStore, for: collectionView, cellCommunicatesWith: WeaponSmith())
            case .rerollable:
                AppProvider.randomWeaponDatasourceWithRerollAction = AppProvider.randomWeaponDatasourceWithRerollAction ?? RandomRerollableWeaponsDatasource(backedBy: [[]], for: collectionView)
            case .completelyRandom:
                AppProvider.randomWeaponDatasource = AppProvider.randomWeaponDatasource ?? RandomWeaponsDatasource(backedBy: [[]], for: collectionView, cellCommunicatesWith: nil)
            case .mixed:
                AppProvider.mixedWeaponsDatasource = AppProvider.generateCombinedDatasource()
            }
            
            collectionView.dataSource = newValue.selectedWeaponDatasource
            collectionView.delegate = newValue.selectedWeaponDatasource
            
            // now that the datasource is updated with the appropriate list we can resolve the loading state
            newValue.isWaitingForWeaponsToLoad = false
        }
        
        // return the new value for the datasource context
        return newValue
    }
    
    // MARK: Convenience method for generating composite datasource (a datasource that aggregates multiple datasources into a single datasource)
    static func generateCombinedDatasource() -> WeaponCombinationDatasource {
        return WeaponCombinationDatasource(withSources: [
            AppProvider.upgradableWeaponDatasource,
            AppProvider.weaponInfoDatasource,
            AppProvider.randomWeaponDatasource,
            AppProvider.randomWeaponDatasourceWithRerollAction
            ].compactMap { $0 }
        )
    }
}
