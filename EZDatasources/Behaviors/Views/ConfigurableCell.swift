//
//  ConfigurableCell.swift
//  GenericDataSource
//
//  Created by Andrea Prearo on 4/20/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import UIKit

//public protocol EZCell: EZView, ReusableCell {}
//public protocol EZActionableCell: EZActionableView, ReusableCell {}
//public protocol EZModelDrivenCell: EZModelDrivenView, ReusableCell {}
//public protocol EZActionableModelDrivenCell: EZActionableModelDrivenView, ReusableCell {}
public protocol EZCell: EZView, ReusableCell {}

public protocol EZCellWrappingView: EZCell where View: EZView {
    associatedtype View where View: UIView
    var wrappedView: View? { get set }
}

//public protocol EZCellWrappingActionableModelDrivenView: EZActionableModelDrivenCell, EZCellWrappingView where View: EZActionableModelDrivenView {}

//public protocol EZCellWrappingActionableView: EZActionableCell, EZCellWrappingView where View: EZActionableView {}
//public protocol EZCellWrappingModelDrivenView: EZModelDrivenCell, EZCellWrappingView where View: EZModelDrivenView {}
//public protocol EZCellWrappingActionableModelDrivenView: EZActionableModelDrivenCell, EZCellWrappingView where View: EZActionableModelDrivenView {}
