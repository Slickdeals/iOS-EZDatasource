//
//  WeaponHandler.swift
//  AwesomeWeaponModel
//
//  Created by Dominic Rodriquez on 7/11/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation

public protocol WeaponInteractionHandler {
    func didRequestWeaponUpgrade(for weapon: Weapon, at indexPath: IndexPath?)
    func didRerollWeapon(at indexPath: IndexPath?, to weapon: Weapon)
}

public extension WeaponInteractionHandler {
    public func didRerollWeapon(at indexPath: IndexPath?, to weapon: Weapon) {
        guard let index = indexPath else { return }
        WeaponStore.AvailableWeapons[index.item] = weapon
    }
}
