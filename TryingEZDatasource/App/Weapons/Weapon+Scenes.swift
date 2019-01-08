//
//  Weapon+Scenes.swift
//  TryingEZDatasource
//
//  Created by Dominic Rodriquez on 7/11/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit
import COGuide
import AwesomeWeaponModel

struct SomeAsshole: GuidedModel {
    var generalAppearance: String = "kind of like a dick"
    
    var asViewModel: SomeAsshole.ViewModel {
        let isDick = generalAppearance.contains("dick")
        return ViewModel(appearanceText: generalAppearance, theme: isDick ? .fritzFancy : .regular)
    }
}

extension SomeAsshole {
    struct ViewModel: GuidedModel {
        
        enum Theme {
            case regular
            case fritzFancy
        }
        
        var appearanceText: String
        var theme: Theme
        var backgroundColor: UIColor {
            switch theme {
            case .regular: return UIColor.red
            case .fritzFancy: return UIColor.brown
            }
        }
    }
}

struct BullshitHandler {
    func handleBullshit(from asshole: SomeAsshole) {
        print("Some guys that looks \(asshole.generalAppearance) tries to give you shit and you handle it")
    }
}

class BullshitCell: GuidedCollectionViewCell<SomeAsshole, BullshitHandler> {
    
    @IBOutlet weak var assholesAppearance: UILabel!
    
    @IBAction func promptedAsshole(_ sender: UIButton) {
        guard let someAsshole = model else { return }
        interactor?.handleBullshit(from: someAsshole)
    }
    
//    override func didUpdate() {
//        guard let asshole = self.model else { return }
//        assholesAppearance.text = asshole.generalAppearance
//    }
}

class SuperBullshitCell: BullshitCell {}
class MegaBullshitCell: BullshitCell {}

class SimpleScene: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let assholeDatasource = BullshitCell.makeDatasource()
    let fuckingDatasource = SuperBullshitCell.makeDatasource()
    let gtfoDatasource = MegaBullshitCell.makeDatasource()
    
    let bullshitHandler = BullshitHandler()
    
    let assholeDSOne = SomeAsshole.makeDatasource(for: BullshitCell.self)
    let assholeDSTwo = SomeAsshole.makeDatasource(for: SuperBullshitCell.self)
    let assholeDSThree = SomeAsshole.makeDatasource(for: MegaBullshitCell.self)
    
    lazy var ManyBullshitSources: CompositeDataSource = {
        return CompositeDataSource(withSources: [fuckingDatasource, assholeDatasource, gtfoDatasource])
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assholeDatasource.drive(contentsOf: collectionView, cellCommunicatesWith: bullshitHandler)
        assholeDatasource.startObserving { update in
            
            print(update.oldValue)
            print(update.value)
            
            switch update.triggedBy {
            case .addItem(_, let section): self.collectionView.reloadSections(IndexSet([section]))
            case .addItems(_, let section): self.collectionView.reloadSections(IndexSet([section]))
            case .removeItem(let indexPath): self.collectionView.reloadItems(at: [indexPath])
            default: self.collectionView.reloadData()
            }
        }
    }
    
    func didReceiveUpdate(assholes: [SomeAsshole]) {
        assholeDatasource.perform(action: .updateAll(with: [assholes]))
        assholeDatasource.perform(action: .updateAll(with: [assholes]))
    }
}

/***************************************************************************************************************
 Three different view controllers, each of which displays one of the cells created above
 ***************************************************************************************************************/
class WeaponsVC : UIViewController {
    var subscriberID: String?
    lazy var collectionView: UICollectionView = {
        return ViewBuilder.collectionView(frame: view.bounds)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        App.provider.perform(action: AppProvider.Event.didRequestWeaponList(ofType: .upgradable))
    }
    
    func subscribeToApp() {
        guard subscriberID == nil else { return }
        
        subscriberID = App.sharedInstance.startObserving { appUpdate in
            guard
                let newList = appUpdate.value.provider.weaponListInView,
                    appUpdate.oldValue.provider.weaponListInView != newList,
                    appUpdate.value.provider.isWaitingForWeaponsToLoad
                else { return }
            
            App.provider.perform(action: .loadWeaponList(into: self.collectionView))
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.addSubview(collectionView)
        subscribeToApp()
        App.provider.perform(action: .loadWeaponList(into: self.collectionView))
    }
}
