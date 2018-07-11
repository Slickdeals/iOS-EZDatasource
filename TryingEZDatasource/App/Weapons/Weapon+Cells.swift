//
//  Weapon+Cells.swift
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
 Three different cells, each of which is from one of the 3 possible subclasses
 Those three are
 
 - EZActionableCollectionViewCell<Delegate>
 cell that can received some user action and would want to communicate that to a delegate/handler
 content is not driven by any model
 
 - EZModelDrivenCollectionViewCell<Model>
 cell that's driven by model, but has no actionable content within it
 
 - EZActionableModelDrivenCollectionViewCell<Model, Delegate>
 cell that combines both of the other cases
 
 *************************************/
class RandomWeaponCell: EZActionableCollectionViewCell<WeaponInteractionHandler> {
    
    var randomWeapon: Weapon = WeaponStore.randomWeapon
    lazy var refreshWeaponButton: UIButton = { return ViewBuilder.buildButton() }()
    lazy var weaponLabel: UILabel = { return ViewBuilder.buildLevel(size: self.contentView.bounds.size) }()
    
    override func setup(with actionDelegate: WeaponInteractionHandler?) {
        print("setting up")
        super.setup(with: actionDelegate)
        contentView.backgroundColor = UIColor.orange
        weaponLabel.text = "\(randomWeapon.name)"
        guard !subviews.contains(refreshWeaponButton) else { return }
        contentView.addSubview(refreshWeaponButton)
        contentView.addSubview(weaponLabel)
        refreshWeaponButton.setTitle("⚅", for: .normal)
        refreshWeaponButton.addTarget(self, action: #selector(self.tappedRerollWeapon), for: .touchUpInside)
    }
    
    @objc func tappedRerollWeapon() {
        randomWeapon = WeaponStore.randomWeapon
        delegate?.didRequestWeaponUpgrade(for: randomWeapon)
    }
}

class WeaponInfoCell: EZModelDrivenCollectionViewCell<Weapon> {
    
    lazy var levelLabel: UILabel = { return ViewBuilder.buildLevel(size: self.contentView.bounds.size) }()
    
    override func setup(for model: Model?, at indexPath: IndexPath?) {
        print("setting up")
        super.setup(for: model, at: indexPath)
        contentView.backgroundColor = UIColor.orange
        if let model = model { levelLabel.text = "\(model.name): \(model.level)" }
        guard !subviews.contains(levelLabel) else { return }
        contentView.addSubview(levelLabel)
    }
}

class WeaponCell: EZActionableModelDrivenCollectionViewCell<Weapon, WeaponInteractionHandler> {
    
    lazy var upgradeButton: UIButton = { return ViewBuilder.buildButton() }()
    lazy var levelLabel: UILabel = { return ViewBuilder.buildLevel(size: self.contentView.bounds.size) }()
    
    override func setup(for model: Weapon?, at indexPath: IndexPath?, with actionDelegate: WeaponInteractionHandler?) {
        super.setup(for: model, at: indexPath, with: actionDelegate)
        print("setting up")
        contentView.backgroundColor = UIColor.orange
        if let model = model { levelLabel.text = "\(model.name): \(model.level)" }
        guard !subviews.contains(upgradeButton) else { return }
        contentView.addSubview(upgradeButton)
        contentView.addSubview(levelLabel)
        print("adding subview")
        upgradeButton.addTarget(self, action: #selector(self.tappedUpgrade), for: .touchUpInside)
        
    }
    
    @objc func tappedUpgrade() {
        guard let weapon = model else { return }
        delegate?.didRequestWeaponUpgrade(for: weapon)
    }
}
