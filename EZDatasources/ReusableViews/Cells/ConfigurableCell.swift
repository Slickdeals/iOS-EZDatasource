//
//  ConfigurableCell.swift
//  GenericDataSource
//
//  Created by Andrea Prearo on 4/20/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import UIKit

public protocol EZCell: EZView, ReusableCell {}

public protocol EZCellWrappingView: EZCell where View: EZView {
    associatedtype View where View: UIView
    var wrappedView: View? { get set }
}
