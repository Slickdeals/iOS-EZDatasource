//
//  Weapon+Interactor.swift
//  AwesomeWeaponModel
//
//  Created by Dominic Rodriquez on 7/11/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation

public struct WeaponSmith: WeaponInteractor {
    public init() {}
}

public protocol WeaponInteractor {
    func didRequestWeaponUpgrade(for weapon: Weapon, at indexPath: IndexPath?)
    func didRerollWeapon(at indexPath: IndexPath?, to weapon: Weapon)
    init()
}

public extension WeaponInteractor {
    
    func didRerollWeapon(at indexPath: IndexPath?, to weapon: Weapon) {
        guard let index = indexPath else { return }
        WeaponStore.AvailableWeapons[index.item] = weapon
    }
    
    func didRequestWeaponUpgrade(for weapon: Weapon, at indexPath: IndexPath?) {
        WeaponStore.upgrade(weapon)
    }
}
