//
//  Weapon+Store.swift
//  AwesomeWeaponModel
//
//  Created by Dominic Rodriquez on 7/11/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import COGuide

//public class CustomWeaponStore: ArrayStore<Weapon> {
    
//    override open func fetch(didLoadSuccessfully: FetchOneSuccess, didFail: FetchFailure) {
//        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 2) {
//            DispatchQueue.main.async {
//                WeaponStore.refreshWeapons()
//            }
//        }
//    }
//
//    override open func fetchAll(didLoadSuccessfully: FetchAllSuccess, didFail: FetchFailure) {
//        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 2) {
//            DispatchQueue.main.async {
//                WeaponStore.refreshWeapons()
//            }
//        }
//    }
//}

public class WeaponStore {
    
    public static var weaponStore = ArrayStore<Weapon>(items: WeaponStore.AvailableWeapons)

    public static var AvailableWeapons: [Weapon] = Weapon.TypeOfWeapon.allCases.map { Weapon(weaponType: $0) } {
        didSet {
            weaponStore.perform(action: ArrayStore<Weapon>.Update.updateAll(with: [WeaponStore.AvailableWeapons]))
        }
    }

    public static var randomWeapon: Weapon {
        let randomWeaponIndex = Int(arc4random_uniform(UInt32(WeaponStore.AvailableWeapons.count - 1)))
        return WeaponStore.AvailableWeapons[randomWeaponIndex]
    }

    public static func upgrade(_ weapon: Weapon) {
        guard let weaponIndex = AvailableWeapons.index(where: { $0.name == weapon.name })
        else { return }
        AvailableWeapons[weaponIndex].upgrade()
        weaponStore.perform(action: ArrayStore<Weapon>.Update.updateItem(at: IndexPath(item: weaponIndex, section: 0), withItem: weapon))
    }
    
    public static func refreshWeapons() {
        AvailableWeapons = Weapon.TypeOfWeapon.allCases.map { Weapon(weaponType: $0) }
    }
    
    public init() {}
}
