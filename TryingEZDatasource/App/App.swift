//
//  App.swift
//  TryingEZDatasource
//
//  Created by Dominic Rodriquez on 7/11/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import EZDatasources
import UIKit

class App: ExplicitEventBroker  {
    
    static var sharedInstance = App()
    
    typealias EventData = UICollectionViewDataSource & UICollectionViewDelegate
    typealias EventDataCollection = [EventData]
    
    var eventsAvailable: [String] = Event.AllEvents
    var basicSubscribedEvents: [String: [BasicSubscriberAction]] = [:]
    var subscribedEvents: [String: [Subscriber]] = [:]
    var subscribedCollectionEvents: [String: [CollectionSubscriber]] = [:]
    
    static var reactiveWeaponDatasource: ReactiveWeaponDatasource?
    static var weaponInfoDatasource: WeaponInfoDatasource?
    static var randomWeaponDatasourceWithRerollAction: RandomRerollableWeaponsDatasource?
    static var randomWeaponDatasource: RandomWeaponsDatasource?
    
    static var weaponCollectionDatasource: WeaponCombinationDatasource = App.generateCombinedDatasource()
    
    static func generateCombinedDatasource() -> WeaponCombinationDatasource {
        var datasources: [UICollectionViewDataSource & UICollectionViewDelegate] = []
        if let randomWeaponDatasource = randomWeaponDatasource {
            datasources.append(randomWeaponDatasource)
        }
        if let randomWeaponDatasourceWithRerollAction = randomWeaponDatasourceWithRerollAction {
            datasources.append(randomWeaponDatasourceWithRerollAction)
        }
        if let weaponInfoDatasource = weaponInfoDatasource {
            datasources.append(weaponInfoDatasource)
        }
        if let reactiveDatasource = reactiveWeaponDatasource {
            datasources.append(reactiveDatasource)
        }
        return WeaponCombinationDatasource(withSources: datasources)
    }
    
    
    public init() {}
    
}

extension App {
    
    public enum Event: String {
        case didSelectNoActionNoModelDatasource
        case didSelectActionNoModelDatasource
        case didSelectNoActionModelDatasource
        case didSelectActionAndActionReactiveDatasource
        case didSelectAllTheThings
        
        static var AllEvents: [String] {
            let events: [App.Event] = [
                .didSelectNoActionNoModelDatasource,
                .didSelectActionNoModelDatasource,
                .didSelectNoActionModelDatasource,
                .didSelectActionAndActionReactiveDatasource,
                .didSelectAllTheThings
            ]
            return events.map { $0.rawValue }
        }
    }
}
