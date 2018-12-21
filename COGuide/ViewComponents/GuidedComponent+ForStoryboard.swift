//
//  GuideComponent+ForStoryboard.swift
//  COGuide
//
//  Created by Dominic Rodriquez on 12/20/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit

public protocol GuidedForStoryboard: class {
    static var storyboardIdentifier: String? { get }
}

public extension GuidedForStoryboard {
    static var storyboardIdentifier: String? { return nil }
}

public protocol GuidedForNib: GuidedForReuse, GuidedForStoryboard {
    static var nib: CellNib? { get }
    static var registerNib: Bool { get }
}

public extension GuidedForNib {
    public static var registerNib: Bool { return false }
    public static var nib: CellNib? { return CellNib(nibName: reuseIdentifier) }
}
