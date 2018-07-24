//
//  CollectionViewVerticalFlowLayout.swift
//  SlickdealsCore
//
//  Created by Dominic Rodriquez on 6/20/18.
//  Copyright © 2018 Slickdeals, LLC. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable open class SDVerticalGridLayout: UICollectionViewFlowLayout {
    
    @IBInspectable public var columnCount: Int = 3 {
        didSet { setup() }
    }
    @IBInspectable public var compactWidth: CGFloat = 110 {
        didSet { setup() }
    }
    @IBInspectable public var regularWidth: CGFloat = 150 {
        didSet { setup() }
    }
    @IBInspectable public var itemHeight: CGFloat = 130 {
        didSet { setup() }
    }
    @IBInspectable public var insets: CGFloat = 10.0 {
        didSet { setup() }
    }
    @IBInspectable public var betweenItemSpacing: CGFloat = 9.0 {
        didSet { setup() }
    }
    @IBInspectable public var minLineSpacing: CGFloat = 12 {
        didSet { setup() }
    }
    
    public var sizeForItem: CGSize {
        let itemWidth = UIDevice.current.userInterfaceIdiom == .pad ? regularWidth : compactWidth
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    public var startingInsets: UIEdgeInsets {
        return UIEdgeInsets.init(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        //return UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
    }
    
    public override init() {
        super.init()
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public func setup(for containerWidth: CGFloat? = nil) {

        minimumInteritemSpacing = betweenItemSpacing
        minimumLineSpacing = minLineSpacing
        scrollDirection = .vertical
        itemSize = sizeForItem
        
        let startingInsets = self.startingInsets
        sectionInset = calculateRequiredInsets(
            for: containerWidth ?? collectionView?.bounds.width ?? 0.0,
            itemWidth: sizeForItem.width,
            columnCount: CGFloat(columnCount),
            withExistingInsets: startingInsets.left + startingInsets.right)
    }
    
    private func calculateRequiredInsets(for containerWidth: CGFloat,
                                         itemWidth: CGFloat,
                                         columnCount: CGFloat,
                                         withExistingInsets insets: CGFloat) -> UIEdgeInsets {
        
        let lineWidth = columnCount * itemWidth
        let requiredLineSpace = insets + (lineWidth + ((columnCount - 1) * minimumInteritemSpacing))
        
        let insetValue = insets / 2
        let paddingInset = floor((containerWidth - requiredLineSpace) / 2)
        let sectionInsets = UIEdgeInsets.init(top:insetValue, left: insetValue + paddingInset, bottom: insetValue, right: paddingInset + insetValue)
        //let sectionInsets = UIEdgeInsetsMake(insetValue, insetValue + paddingInset, insetValue, paddingInset + insetValue)
        
        guard containerWidth >= requiredLineSpace else {
            return calculateRequiredInsets(for: containerWidth,
                                           itemWidth: itemWidth,
                                           columnCount: columnCount - 1,
                                           withExistingInsets: insets)
        }
        
        return sectionInsets
    }
}
