//
//  WeaponSmith.swift
//  TryingEZDatasource
//
//  Created by Dominic Rodriquez on 7/11/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation

public class WeaponSmith: WeaponInteractionHandler {
    public func didRequestWeaponUpgrade(for weapon: Weapon) {
        weapon.upgrade()
        print(weapon.level)
    }
    
    public init() {}
}
