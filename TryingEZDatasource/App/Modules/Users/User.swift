//
//  User.swift
//  TryingEZDatasource
//
//  Created by Dominic Rodriquez on 6/20/19.
//  Copyright © 2019 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit
import COGuide

struct UserModel: GuidedModel {
    var name: String
}

struct UserCellHandler {
    func handleUserTap(from user: UserModel) {
        print(user.name)
    }
}
