//
//  Launchpad.swift
//  TryingEZDatasource
//
//  Created by Dominic Rodriquez on 7/11/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit
import AwesomeWeaponModel

class LaunchpadViewController: UIViewController {
    
    @IBAction func didTapNotActionableNotModelDriven(_ sender: UIButton) {
        App.provider.perform(action: AppProvider.Event.didRequestWeaponList(ofType: .completelyRandom))
        //App.sharedInstance.publish(event: App.Event.didSelectNoActionNoModelDatasource.rawValue)
    }
    
    @IBAction func didTapActionableNotModelDriven(_ sender: UIButton) {
        App.provider.perform(action: AppProvider.Event.didRequestWeaponList(ofType: .rerollable))
        //App.sharedInstance.publish(event: App.Event.didSelectActionNoModelDatasource.rawValue)
    }
    
    @IBAction func didTapNotActionableModelDriven(_ sender: UIButton) {
        App.provider.perform(action: AppProvider.Event.didRequestWeaponList(ofType: .descriptionsOnly))
        //App.sharedInstance.publish(event: App.Event.didSelectNoActionModelDatasource.rawValue)
    }
    
    @IBAction func didTapActionableReactiveModelDriven(_ sender: UIButton) {
        App.provider.perform(action: AppProvider.Event.didRequestWeaponList(ofType: .upgradable))
        //App.sharedInstance.publish(event: App.Event.didSelectActionAndActionReactiveDatasource.rawValue)
    }
    
    @IBAction func didTapAllTheThings(_ sender: UIButton) {
        App.provider.perform(action: AppProvider.Event.didRequestWeaponList(ofType: .mixed))
        //App.sharedInstance.publish(event: App.Event.didSelectAllTheThings.rawValue)
    }
    
    @IBAction func didTapRefresh(_ sender: UIButton) {
        WeaponStore.refreshWeapons()
    }
    
}
