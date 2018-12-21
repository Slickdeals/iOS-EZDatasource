//
//  GuidedComponent.swift
//  COGuide
//
//  Created by Dominic Rodriquez on 12/20/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit

public protocol GuidedComponent: GuidedForReuse, GuidedForStoryboard {
    associatedtype Model
    associatedtype Interactor
    
    var model: Model? { get set }
    var interactor: Interactor? { get set }
    
    func configure(with model: Model?, at position: IndexPath?, communicatesWith interactionDelegate: Interactor?)
}
