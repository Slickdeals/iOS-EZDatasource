//
//  Weapon+Store.swift
//  AwesomeWeaponModel
//
//  Created by Dominic Rodriquez on 7/11/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import EZDatasources

public class CustomWeaponProvider: ReactiveArrayDataProvider<Weapon> {
    
    override open func fetch(didLoadSuccessfully: FetchOneSuccess, didFail: FetchFailure) {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 2) {
            DispatchQueue.main.async {
                WeaponStore.refreshWeapons()
            } 
        }
    }
    
    override open func fetchAll(didLoadSuccessfully: FetchAllSuccess, didFail: FetchFailure) {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 2) {
            DispatchQueue.main.async {
                WeaponStore.refreshWeapons()
            }
        }
    }
}

public class WeaponStore {
    
    public static var weaponProvider = CustomWeaponProvider(array: WeaponStore.AvailableWeapons)

    public static var AvailableWeapons: [Weapon] = Weapon.TypeOfWeapon.allCases.map { Weapon(weaponType: $0) } {
        didSet {
            weaponProvider.publish(event: ProviderEvent.didLoadItemCollection.rawValue,
                                   with: WeaponStore.AvailableWeapons)
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
        weaponProvider.publish(event: ProviderEvent.didLoadItem.rawValue, with: weapon)
    }
    
    public static func refreshWeapons() {
        AvailableWeapons = Weapon.TypeOfWeapon.allCases.map { Weapon(weaponType: $0) }
    }
    
    public init() {
        //WeaponStore.AvailableWeapons = Weapon.TypeOfWeapon.allCases.map({ Weapon(weaponType: $0) })
    }
}
