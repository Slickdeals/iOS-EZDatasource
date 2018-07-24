//
//  Weapon+Scenes.swift
//  TryingEZDatasource
//
//  Created by Dominic Rodriquez on 7/11/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit
import EZDatasources
import AwesomeWeaponModel

/***************************************************************************************************************
 Three different view controllers, each of which displays one of the cells created above
 ***************************************************************************************************************/
class WeaponsVC : UIViewController {
    
    let subscriberID: String = UUID().uuidString
    
    lazy var collectionView: UICollectionView = {
        return ViewBuilder.collectionView(frame: view.bounds) 
    }()
    
    let weaponSmith = WeaponSmith()
    func handleAppEvent(eventName: String) {
        guard let appEvent = App.Event(rawValue: eventName) else { return }
        switch appEvent {
        case .didSelectNoActionNoModelDatasource:
            App.randomWeaponDatasource = RandomWeaponsDatasource(
                collectionView: self.collectionView,
                array: [[]])
        case .didSelectActionNoModelDatasource:
            App.randomWeaponDatasourceWithRerollAction = RandomRerollableWeaponsDatasource(
                collectionView: self.collectionView,
                array: [[]],
                cellDelegate: nil)
        case .didSelectNoActionModelDatasource:
            App.weaponInfoDatasource = WeaponInfoDatasource(
                collectionView: self.collectionView,
                array: [WeaponStore.AvailableWeapons])
        case .didSelectActionAndActionReactiveDatasource:
            App.reactiveWeaponDatasource = ReactiveWeaponDatasource(
                collectionView: collectionView,
                provider: WeaponStore.weaponProvider,
                cellDelegate: weaponSmith)
        case .didSelectAllTheThings:
            App.weaponCollectionDatasource = App.generateCombinedDatasource()
            self.collectionView.dataSource = App.weaponCollectionDatasource
            self.collectionView.delegate = App.weaponCollectionDatasource
            self.collectionView.reloadData()
        }
        DispatchQueue.main.async { self.collectionView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        App.Event.AllEvents.forEach {
            App.sharedInstance.subscribe(to: $0, subscriber: subscriberID, with: handleAppEvent)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.addSubview(collectionView)
        App.reactiveWeaponDatasource?.loadAll()
    }
}
