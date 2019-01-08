//
//  GuidedCollectionReusableView.swift
//  COGuide
//
//  Created by Dominic Rodriquez on 12/20/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation


public protocol GuidedCollectionReusableView: GuidedComponent {
    static var kind: UICollectionView.ReusableViewType { get }
}
