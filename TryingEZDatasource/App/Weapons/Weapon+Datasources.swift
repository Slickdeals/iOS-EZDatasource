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
 Three different data sources
 *************************************/
class WeaponDataSource: EZCollectionArrayDatasource<WeaponCell> {}
class WeaponInfoDatasource: EZCollectionArrayDatasource<WeaponInfoCell> {}
class RandomWeaponDatasource: EZCollectionArrayDatasource<RandomWeaponCell> {
    override func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return 20 }
}
