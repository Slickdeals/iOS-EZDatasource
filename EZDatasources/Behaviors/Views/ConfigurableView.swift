//
//  EZView.swift
//  SlickdealsCore
//
//  Created by Dominic Rodriquez on 6/20/18.
//  Copyright © 2018 Slickdeals, LLC. All rights reserved.
//

import Foundation
import UIKit

public protocol EZView: class {
    associatedtype Model
    associatedtype Delegate
    
    var model: Model? { get set }
    var delegate: Delegate? { get set }
    func setup(for model: Model?, at indexPath: IndexPath?, with actionDelegate: Delegate?)
}

extension EZView {
//    func setup(for model: Model?, at indexPath: IndexPath?, with actionDelegate: Delegate?) {
//        self.model = model
//        self.delegate = actionDelegate
//    }
}
