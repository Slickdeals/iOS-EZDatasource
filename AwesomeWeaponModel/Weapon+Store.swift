//
//  Weapon+Store.swift
//  AwesomeWeaponModel
//
//  Created by Dominic Rodriquez on 7/11/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation

public struct WeaponStore {
    
    public static var AvailableWeapons: [Weapon] = Weapon.TypeOfWeapon.allCases.map { Weapon(weaponType: $0) }
    
    public static var randomWeapon: Weapon {
        let randomWeaponIndex = Int(arc4random_uniform(UInt32(WeaponStore.AvailableWeapons.count - 1)))
        return WeaponStore.AvailableWeapons[randomWeaponIndex]
    }
}
