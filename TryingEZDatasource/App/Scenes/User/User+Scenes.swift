//
//  SomeSingleCollectionVC.swift
//  TryingEZDatasource
//
//  Created by Dominic Rodriquez on 1/7/19.
//  Copyright © 2019 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit
import COGuide

class UserViewController: UIViewController {
    
    @IBOutlet weak var userCollection: UICollectionView!
    
    var userDatasource = UserModel.makeDatasource(for: UserCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ok well I need granular control over when this thing updates, what updated it, and what I need to do based on what it was before
        // so what about all THAT shit?!
        
        // just subscribe bro
        userDatasource.startObserving { update in
            // each time you're updated, you'll receive the previous value, the new value, and the action that triggered the update
            switch update.triggedBy {
            case .addItems(let items, let section):
                // do some stuff
                print("added items: \(items)")
                self.userCollection.reloadSections(IndexSet([section]))
            default:
                self.userCollection.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // now I just need tell my datasource to drive the collectionView data
        userDatasource.drive(contentsOf: userCollection, cellCommunicatesWith: UserCellHandler())
    }
    
    func usersUpdated(with users: [UserModel]) {
        // That's cool, but how the hell do I work with this thing? How do I update it, how do I know when data is changing?
        
        // The datasource is backed by a store, and all stores have the ability for you to perform actions on them
        userDatasource.publish(action: ArrayStore<UserModel>.Update.updateAll(with: [users]))
    }
    
}

