//
//  Weapon+Datasources.swift
//  TryingEZDatasource
//
//  Created by Dominic Rodriquez on 7/11/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit
import EZDatasources
import AwesomeWeaponModel

// Why do I have to have a collectionView

/*************************************
    Step 2. Various ways you might create datasources
 *************************************/

// an example where it's not model driven so I just override to provide it's content count
class RandomRerollableWeaponsDatasource: StoreArrayDatasource<RandomRerollableWeaponCell> {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
}

class RandomWeaponsDatasource: StoreArrayDatasource<RandomWeaponCell> {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
}

// Actionable, ModelDriven, and reactive (reactive datasources need you to supply the store beacuse the datasource internally subscribes to that store)
class UpgradableWeaponDatasource: StoreArrayDatasource<WeaponCell> {}

class WeaponCombinationDatasource: CompositeDataSource {}

