//
//  GuidedCollectionViewCell.swift
//  COGuide
//
//  Created by Dominic Rodriquez on 12/20/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit

public protocol CellGuide: GuidedCell {
    func didUpdateModel(with updatedModel: Model)
    func didUpdateInteractionDelegate(with interactionDelegate: Interactor)
}

public extension CellGuide {
    func didUpdateInteractionDelegate(with interactionDelegate: Interactor) {}
}

open class GuidedTableViewCell<ModelType, ActionDelegate>: UITableViewCell, GuidedCell {
    public typealias Model = ModelType
    public typealias Interactor = ActionDelegate
    
    public typealias CellModel = Model
    public typealias CellInteractor = Interactor
    
    open var model: Model?
    open var interactor: Interactor?
    open var indexPath: IndexPath?
    
    open override func prepareForReuse() {
        model = nil
        interactor = nil
        indexPath = nil
    }
    
    open func configure(with model: Model?, at position: IndexPath?, communicatesWith interactionDelegate: Interactor?) {
        self.model = model
        self.interactor = interactionDelegate
        self.indexPath = position
    }
}

open class GuidedCollectionViewCell<ModelType, ActionDelegate>: UICollectionViewCell, GuidedCell {
    public typealias Model = ModelType
    public typealias Interactor = ActionDelegate
    
    public typealias CellModel = Model
    public typealias CellInteractor = Interactor
    
    open var model: Model?
    open var interactor: Interactor?
    open var indexPath: IndexPath?
    
    open override func prepareForReuse() {
        model = nil
        interactor = nil
        indexPath = nil
    }
    
    open func configure(with model: Model?, at position: IndexPath?, communicatesWith interactionDelegate: Interactor?) {
        self.model = model
        self.interactor = interactionDelegate
        self.indexPath = position
    }
}


open class GuidedEmptyCollectionViewCell: UICollectionViewCell, GuidedCell {
    public typealias Model = CellEmptyModel
    public typealias Interactor = CellEmptyActionDelegate
    open var model: Model?
    open var interactor: Interactor?

    open override func prepareForReuse() {
        model = nil
        interactor = nil
    }

    open func configure(with model: Model?, at position: IndexPath?, communicatesWith interactionDelegate: Interactor?) {
        self.model = model
        self.interactor = interactionDelegate
        self.configure(at: position)
    }

    open func configure(at position: IndexPath?) {}
}

open class GuidedActionableCollectionViewCell<ActionDelegate>: UICollectionViewCell, GuidedCell {
    public typealias Model = CellEmptyModel
    public typealias Interactor = ActionDelegate
    open var model: Model?
    open var interactor: Interactor?
    
    open override func prepareForReuse() {
        model = nil
        interactor = nil
    }
    
    open func configure(with model: Model?, at position: IndexPath?, communicatesWith interactionDelegate: Interactor?) {
        self.model = model
        self.interactor = interactionDelegate
        self.configure(at: position, communicatesWith: interactor)
    }
    
    open func configure(at position: IndexPath?, communicatesWith interactionDelegate: Interactor?) {}
}

open class GuidedModelDrivenCollectionViewCell<ModelType>: UICollectionViewCell, GuidedCell {
    public typealias Model = ModelType
    public typealias Interactor = CellEmptyActionDelegate
    open var model: Model?
    open var interactor: Interactor?
    
    open override func prepareForReuse() {
        model = nil
        interactor = nil
    }
    
    open func configure(with model: Model?, at position: IndexPath?, communicatesWith interactionDelegate: Interactor?) {
        self.model = model
        self.interactor = interactionDelegate
        self.configure(with: model, at: position)
    }
    
    open func configure(with model: Model?, at position: IndexPath?) {}
}

open class GuidedActionableModelDrivenCollectionViewCell<ModelType, ActionDelegate>: UICollectionViewCell, GuidedCell {
    public typealias Model = ModelType
    public typealias Interactor = ActionDelegate
    open var model: Model?
    open var interactor: Interactor?
    
    open override func prepareForReuse() {
        model = nil
        interactor = nil
    }
    
    open func configure(with model: Model?, at position: IndexPath?, communicatesWith interactionDelegate: Interactor?) {
        self.model = model
        self.interactor = interactionDelegate
    }
}

public protocol CellEmptyActionDelegate { var oops: Bool { get  } }
public protocol CellEmptyModel { var oops: Bool { get } }
public extension CellEmptyActionDelegate { var oops: Bool { return false } }
public extension CellEmptyModel { var oops: Bool { return false } }
