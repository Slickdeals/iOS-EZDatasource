//
//  CellNib.swift
//  COGuide
//
//  Created by Dominic Rodriquez on 12/20/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
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
