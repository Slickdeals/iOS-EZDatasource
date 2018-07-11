//
//  CellNib.swift
//  SlickdealsCore
//
//  Created by Dominic Rodriquez on 6/22/18.
//  Copyright © 2018 Slickdeals, LLC. All rights reserved.
//

import Foundation
import UIKit

public struct CellNib {
    public let nibName: String
    public let bundle: Bundle?
    
    public var nibFile: UINib {
        return UINib(nibName: nibName, bundle: bundle)
    }
    
    public init(nibName: String, bundle: Bundle? = nil) {
        self.nibName = nibName
        self.bundle = bundle
    }
}
