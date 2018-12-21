//
//  GuidedCell+FilledWithView.swift
//  COGuide
//
//  Created by Dominic Rodriquez on 12/20/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit

public protocol GuidedCellCase: GuidedCell where View: GuidedComponent {
    associatedtype View where View: UIView
    var viewConstrainedToCell: View? { get set }
}

