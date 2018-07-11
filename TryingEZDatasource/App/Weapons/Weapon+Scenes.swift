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
        lazy var collectionView: UICollectionView = { return ViewBuilder.collectionView(frame: view.bounds) }()
        var weaponDatasource: WeaponDataSource!
        let weaponSmith = WeaponSmith()
        override func viewDidAppear(_ animated: Bool) {
            weaponDatasource = WeaponDataSource(collectionView: self.collectionView, array: WeaponStore.AvailableWeapons)
            weaponDatasource.cellDelegate = weaponSmith
            view.addSubview(collectionView)
        }
}

class WeaponInfoVC : UIViewController {
    lazy var collectionView: UICollectionView = { return ViewBuilder.collectionView(frame: view.bounds) }()
    var weaponInfoDatasource: WeaponInfoDatasource!
    override func viewDidAppear(_ animated: Bool) {
        weaponInfoDatasource = WeaponInfoDatasource(collectionView: self.collectionView, array: WeaponStore.AvailableWeapons)
        view.addSubview(collectionView)
    }
}

class RandomWeaponVC : UIViewController {
    lazy var collectionView: UICollectionView = { return ViewBuilder.collectionView(frame: view.bounds) }()
    var randomWeaponDatasource: RandomWeaponDatasource!
    let weaponSmith = WeaponSmith()
    override func viewDidAppear(_ animated: Bool) {
        print("appeared")
        randomWeaponDatasource = RandomWeaponDatasource(collectionView: self.collectionView, array: [[]], cellDelegate: weaponSmith)
        view.addSubview(collectionView)
    }
}
