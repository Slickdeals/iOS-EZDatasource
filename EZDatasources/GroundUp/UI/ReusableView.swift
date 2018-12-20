//
//  ReusableView.swift
//  SlickdealsCore
//
//  Created by Dominic Rodriquez on 6/26/18.
//  Copyright © 2018 Slickdeals, LLC. All rights reserved.
//

import UIKit

public protocol ReusableView {
    static var reuseIdentifier: String { get }
    static var storyboardIdentifier: String? { get }
}

public extension ReusableView {
    static var reuseIdentifier: String { return String(describing: self) }
    static var storyboardIdentifier: String? { return nil }
}
