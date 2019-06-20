//
//  GuidedComponent+ForReuse.swift
//  COGuide
//
//  Created by Dominic Rodriquez on 12/20/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit

public protocol GuidedForReuse: class {
    static var reuseIdentifier: String { get }
}

public extension GuidedForReuse {
    static var reuseIdentifier: String { return String(describing: self) }
}
