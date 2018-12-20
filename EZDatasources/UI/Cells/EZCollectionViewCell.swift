//
//  EZCollectionViewCell.swift
//  EZDatasources
//
//  Created by Dominic Rodriquez on 7/11/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit

open class EZActionableCollectionViewCell<ActionDelegate>: UICollectionViewCell, EZCell {
    public typealias Model = EZEmptyModel
    public typealias Delegate = ActionDelegate
    open var model: Model?
    open var delegate: Delegate?
    
    open override func prepareForReuse() {
        model = nil
        delegate = nil
    }
    
    public func setup(for model: Model?, at indexPath: IndexPath?, with actionDelegate: Delegate?) {
        self.model = nil
        self.delegate = actionDelegate
        self.setup(with: delegate, at: indexPath)
    }
    
    open func setup(with actionDelegate: Delegate?, at indexPath: IndexPath?) {}
}

open class EZModelDrivenCollectionViewCell<ModelType>: UICollectionViewCell, EZCell {
    public typealias Model = ModelType
    public typealias Delegate = EZEmptyActionDelegate
    open var model: Model?
    open var delegate: Delegate?
    
    open override func prepareForReuse() {
        model = nil
        delegate = nil
    }
    
    public func setup(for model: Model?, at indexPath: IndexPath?, with actionDelegate: Delegate?) {
        self.model = model
        self.delegate = nil
        self.setup(for: model, at: indexPath)
    }
    
    open func setup(for model: Model?, at indexPath: IndexPath?) {}
}

open class EZActionableModelDrivenCollectionViewCell<ModelType, ActionDelegate>: UICollectionViewCell, EZCell {
    public typealias Model = ModelType
    public typealias Delegate = ActionDelegate
    open var model: Model?
    open var delegate: Delegate?
    
    open override func prepareForReuse() {
        model = nil
        delegate = nil
    }
    
    open func setup(for model: Model?, at indexPath: IndexPath?, with actionDelegate: Delegate?) {
        self.model = model
        self.delegate = actionDelegate
    }
}
