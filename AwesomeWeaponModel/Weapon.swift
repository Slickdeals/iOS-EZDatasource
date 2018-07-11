//
//  Weapon.swift
//  TryingEZDatasource
//
//  Created by Dominic Rodriquez on 7/11/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation

public class Weapon {
    public var name: String
    public var type: Weapon.TypeOfWeapon
    public var level: Int
    
    public init(weaponType: Weapon.TypeOfWeapon) {
        self.name = weaponType.rawValue
        self.type = weaponType
        self.level = 1
    }
    
    public func upgrade() {
        level = level + 1
    }
}

public extension Weapon {
    
    public enum TypeOfWeapon: String {
        case axe, sword, bow, whip, mace, jenga, gunblade, flail, churros, giantEncyclopedia = "giant encyclopedia", rocketLauncher = "rocket launcher", hotSauce = "hot sauce"
        
        public static var allCases: [TypeOfWeapon] {
            return [.axe, .sword, .bow, .whip, .mace, .jenga, .gunblade, .flail, .churros, .giantEncyclopedia, .rocketLauncher, .hotSauce]
        }
    }
}
