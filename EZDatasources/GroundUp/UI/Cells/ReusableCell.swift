//
//  ReusableCell.swift
//  GenericDataSource
//
//  Created by Andrea Prearo on 4/20/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import UIKit

public protocol ReusableCell: ReusableView {
    static var nib: CellNib? { get }
    static var registerNib: Bool { get }
}

public extension ReusableCell {
    public static var registerNib: Bool { return false }
    public static var nib: CellNib? { return CellNib(nibName: reuseIdentifier) }
}
