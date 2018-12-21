//
//  Weapon+Cells.swift
//  TryingEZDatasource
//
//  Created by Dominic Rodriquez on 7/11/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit
import COGuide
import AwesomeWeaponModel

/*************************************
 Three different cells, each of which is from one of the 3 possible subclasses
 Those three are
 
 - GuidedActionableCollectionViewCell<Interactor>
 cell that can received some user action and would want to communicate that to a delegate/handler
 content is not driven by any model
 
 - GuidedModelDrivenCollectionViewCell<Model>
 cell that's driven by model, but has no actionable content within it
 
 - GuidedActionableModelDrivenCollectionViewCell<Model, Interactor>
 cell that combines both of the other cases
 
 *************************************/
class RandomWeaponCell: GuidedCollectionViewCell {
    
    var randomWeapon: Weapon = WeaponStore.randomWeapon
    var indexPath: IndexPath? = nil
    lazy var weaponLabel: UILabel = { return ViewBuilder.buildLevel(size: self.contentView.bounds.size) }()
    
    override func configure(at position: IndexPath?) {
        super.configure(at: position)
        contentView.backgroundColor = UIColor.green
        weaponLabel.text = "\(randomWeapon.name)"
        guard !subviews.contains(weaponLabel) else { return }
        contentView.addSubview(weaponLabel)
    }
}

class RandomRerollableWeaponCell: GuidedActionableCollectionViewCell<WeaponInteractor> {
    
    var randomWeapon: Weapon = WeaponStore.randomWeapon
    var indexPath: IndexPath? = nil
    lazy var refreshWeaponButton: UIButton = { return ViewBuilder.buildButton() }()
    lazy var weaponLabel: UILabel = { return ViewBuilder.buildLevel(size: self.contentView.bounds.size) }()
    
    override func configure(at position: IndexPath?, communicatesWith interactionDelegate: WeaponInteractor?) {
        self.indexPath = position
        super.configure(at: position, communicatesWith: interactionDelegate)
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
        configure(at: indexPath, communicatesWith: interactor)
        interactor?.didRerollWeapon(at: indexPath, to: randomWeapon)
    }
}

class WeaponInfoCell: GuidedModelDrivenCollectionViewCell<Weapon> {

    lazy var levelLabel: UILabel = { return ViewBuilder.buildLevel(size: self.contentView.bounds.size) }()

    override func configure(with model: Model?, at position: IndexPath?) {
        super.configure(with: model, at: position)
        contentView.backgroundColor = UIColor.cyan
        if let model = model { levelLabel.text = "\(model.name): \(model.level)" }
        guard !subviews.contains(levelLabel) else { return }
        contentView.addSubview(levelLabel)
    }
}

class WeaponCell: GuidedActionableModelDrivenCollectionViewCell<Weapon, WeaponInteractor> {

    lazy var upgradeButton: UIButton = { return ViewBuilder.buildButton() }()
    lazy var levelLabel: UILabel = { return ViewBuilder.buildLevel(size: self.contentView.bounds.size) }()
    var indexPath: IndexPath? = nil
    
    override func configure(with model: Weapon?, at position: IndexPath?, communicatesWith interactionDelegate: WeaponInteractor?) {
        super.configure(with: model, at: position, communicatesWith: interactionDelegate)
        self.indexPath = position
        contentView.backgroundColor = UIColor.orange
        if let model = model { levelLabel.text = "\(model.name): \(model.level)" }
        guard !subviews.contains(upgradeButton) else { return }
        contentView.addSubview(upgradeButton)
        contentView.addSubview(levelLabel)
        upgradeButton.addTarget(self, action: #selector(self.tappedUpgrade), for: .touchUpInside)

    }

    @objc func tappedUpgrade() {
        guard let weapon = model else { return }
        interactor?.didRequestWeaponUpgrade(for: weapon, at: indexPath!)
    }
}
