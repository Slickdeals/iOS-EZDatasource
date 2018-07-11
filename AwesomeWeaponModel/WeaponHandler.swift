//
//  WeaponHandler.swift
//  AwesomeWeaponModel
//
//  Created by Dominic Rodriquez on 7/11/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation

public protocol WeaponInteractionHandler {
    func didRequestWeaponUpgrade(for weapon: Weapon)
}
