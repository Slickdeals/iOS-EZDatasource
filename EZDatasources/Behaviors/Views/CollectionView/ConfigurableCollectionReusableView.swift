//
//  ConfigurableCollectionReusableView.swift
//  SlickdealsCore
//
//  Created by Dominic Rodriquez on 6/22/18.
//  Copyright © 2018 Slickdeals, LLC. All rights reserved.
//

import Foundation
import UIKit

public protocol EZCollectionReusableView: EZView, ReusableView {
    static var kind: String { get }
}
