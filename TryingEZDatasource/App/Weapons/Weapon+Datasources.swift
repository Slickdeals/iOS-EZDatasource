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

/*************************************
    Step 2. Various ways you might create datasources
 *************************************/

// This one's model driven, but that's it- no actions
class WeaponInfoDatasource: EZCollectionArrayDatasource<WeaponInfoCell> {}

// an example where it's not model driven so I just override to provide it's content count
class RandomRerollableWeaponsDatasource: EZCollectionArrayDatasource<RandomRerollableWeaponCell> {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
}

class RandomWeaponsDatasource: EZCollectionArrayDatasource<RandomWeaponCell> {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
}

// Actionable, ModelDriven, and reactive (reactive datasources need you to supply the provider beacuse the datasource internally subscribes to that provider)
class ReactiveWeaponDatasource: EZCollectionArrayReactiveDatasource<CustomWeaponProvider, WeaponCell> {}

class WeaponCombinationDatasource: CompositeDataSource {}

