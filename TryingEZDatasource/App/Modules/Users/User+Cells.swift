//
//  User+Cells.swift
//  TryingEZDatasource
//
//  Created by Dominic Rodriquez on 6/20/19.
//  Copyright © 2019 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit
import COGuide

// so i've specified I want to be a guidedCollectionViewCell, now how the hell do I use this thing?
// the easiest step of the process for any guided cell is to just specify that it is a CellGuide, and the protocol will tell you what you need.
class UserCell: GuidedCollectionViewCell<UserModel, UserCellHandler>, CellGuide {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func userTapped(_ sender: UIButton) {
        guard let validUser = model else { return }
        interactor?.handleUserTap(from: validUser)
    }
    
    // this method just notifies you that an update was received. Internally, everything has already been updated
    // so you can safely reference whatever properties you like,
    func didUpdateModel(with updatedModel: Model) {
        nameLabel.text = updatedModel.name
    }
    
    // in order to use this cell, there's just one thing I need to do
}
