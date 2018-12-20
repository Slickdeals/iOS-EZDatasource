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
class RandomWeaponCell: EZCollectionViewCell {
    
    var randomWeapon: Weapon = WeaponStore.randomWeapon
    var indexPath: IndexPath? = nil
    lazy var weaponLabel: UILabel = { return ViewBuilder.buildLevel(size: self.contentView.bounds.size) }()
    
    override func setup(at indexPath: IndexPath?) {
        super.setup(at: indexPath)
        contentView.backgroundColor = UIColor.green
        weaponLabel.text = "\(randomWeapon.name)"
        guard !subviews.contains(weaponLabel) else { return }
        contentView.addSubview(weaponLabel)
    }
}

class RandomRerollableWeaponCell: EZActionableCollectionViewCell<WeaponInteractor> {
    
    var randomWeapon: Weapon = WeaponStore.randomWeapon
    var indexPath: IndexPath? = nil
    lazy var refreshWeaponButton: UIButton = { return ViewBuilder.buildButton() }()
    lazy var weaponLabel: UILabel = { return ViewBuilder.buildLevel(size: self.contentView.bounds.size) }()
    
    override func setup(with actionDelegate: WeaponInteractor?, at indexPath: IndexPath?) {
        self.indexPath = indexPath
        super.setup(with: actionDelegate, at: indexPath)
        contentView.backgroundColor = UIColor.lightGray
        weaponLabel.text = "\(randomWeapon.name)"
        guard !subviews.contains(refreshWeaponButton) else { return }
        contentView.addSubview(refreshWeaponButton)
        contentView.addSubview(weaponLabel)
        refreshWeaponButton.setTitle("⚅", for: .normal)
        refreshWeaponButton.addTarget(self, action: #selector(self.tappedRerollWeapon), for: .touchUpInside)
    }
    
    @objc func tappedRerollWeapon() {
        randomWeapon = WeaponStore.randomWeapon
        setup(with: delegate, at: indexPath)
        delegate?.didRerollWeapon(at: indexPath, to: randomWeapon)
    }
}

class WeaponInfoCell: EZModelDrivenCollectionViewCell<Weapon> {

    lazy var levelLabel: UILabel = { return ViewBuilder.buildLevel(size: self.contentView.bounds.size) }()

    override func setup(for model: Model?, at indexPath: IndexPath?) {
        super.setup(for: model, at: indexPath)
        contentView.backgroundColor = UIColor.cyan
        if let model = model { levelLabel.text = "\(model.name): \(model.level)" }
        guard !subviews.contains(levelLabel) else { return }
        contentView.addSubview(levelLabel)
    }
}

class WeaponCell: EZActionableModelDrivenCollectionViewCell<Weapon, WeaponInteractor> {

    lazy var upgradeButton: UIButton = { return ViewBuilder.buildButton() }()
    lazy var levelLabel: UILabel = { return ViewBuilder.buildLevel(size: self.contentView.bounds.size) }()
    var indexPath: IndexPath? = nil
    
    override func setup(for model: Weapon?, at indexPath: IndexPath?, with actionDelegate: WeaponInteractor?) {
        super.setup(for: model, at: indexPath, with: actionDelegate)
        self.indexPath = indexPath
        contentView.backgroundColor = UIColor.orange
        if let model = model { levelLabel.text = "\(model.name): \(model.level)" }
        guard !subviews.contains(upgradeButton) else { return }
        contentView.addSubview(upgradeButton)
        contentView.addSubview(levelLabel)
        upgradeButton.addTarget(self, action: #selector(self.tappedUpgrade), for: .touchUpInside)

    }

    @objc func tappedUpgrade() {
        guard let weapon = model else { return }
        delegate?.didRequestWeaponUpgrade(for: weapon, at: indexPath!)
    }
}
