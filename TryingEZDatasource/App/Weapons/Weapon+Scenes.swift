//
//  Weapon+Scenes.swift
//  TryingEZDatasource
//
//  Created by Dominic Rodriquez on 7/11/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit
import COGuide
import AwesomeWeaponModel

/***************************************************************************************************************
 Three different view controllers, each of which displays one of the cells created above
 ***************************************************************************************************************/
class WeaponsVC : UIViewController {
    var subscriberID: String?
    lazy var collectionView: UICollectionView = {
        return ViewBuilder.collectionView(frame: view.bounds)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        App.provider.perform(action: AppProvider.Event.didRequestWeaponList(ofType: .upgradable))
    }
    
    func subscribeToApp() {
        guard subscriberID == nil else { return }
        
        subscriberID = App.sharedInstance.startObserving { appUpdate in
            guard
                let newList = appUpdate.value.provider.weaponListInView,
                    appUpdate.oldValue.provider.weaponListInView != newList,
                    appUpdate.value.provider.isWaitingForWeaponsToLoad
                else { return }
            
            App.provider.perform(action: .loadWeaponList(into: self.collectionView))
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.addSubview(collectionView)
        subscribeToApp()
        App.provider.perform(action: .loadWeaponList(into: self.collectionView))
    }
}
