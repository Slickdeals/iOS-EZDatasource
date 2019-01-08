//
//  CollectionArrayDataSource.swift
//  GenericDataSource


import UIKit

open class StoreArrayCollectionDatasource<Model, Cell: UICollectionViewCell>: CollectionDataSource<ArrayStore<Model>, Cell>, Observable
    where Cell: GuidedCell, Cell.Model == Model {
    
    public typealias Action = ArrayStore<Model>.Action
    public typealias Element = ArrayStore<Model>.Element
    
    public var observers: [String: ObserverWrapper<Element, Action>] {
        get {
            return store.observers
        }
        set {
            store.observers = newValue
        }
    }

    public var value: Element {
        get {
            return store.value
        }
        set {
            store.value = newValue
        }
    }
    
    // MARK: - Initializers
    public convenience init(backedBy array: [Model] = [],
                            for collectionView: UICollectionView? = nil,
                            cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) {
        self.init(backedBy: [array], for: collectionView, cellCommunicatesWith: interactionDelegate)
    }
    
    public required init(backedBy array: [[Model]] = [],
                         for collectionView: UICollectionView? = nil,
                         cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) {
        super.init(backedBy: ArrayStore<Model>(items: array), for: collectionView, cellCommunicatesWith: interactionDelegate)
    }
    
    override public init(backedBy store: ArrayStore<Model>,
                         for collectionView: UICollectionView? = nil,
                         cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) {
        super.init(backedBy: store, for: collectionView, cellCommunicatesWith: interactionDelegate)
    }
    
    // MARK: - Public Methods
    open func item(at indexPath: IndexPath) -> Model? {
        return store.item(at: indexPath)
    }
    
    open func updateItem(at indexPath: IndexPath, value: Model) {
        store.perform(action: .updateItem(at: indexPath, withItem: value))
        collectionView?.reloadItems(at: [indexPath])
    }
    
    open func reload(with items: [[Model]]) {
        store.perform(action: .updateAll(with: items))
    }
    
    open func reload(with items: [Model]) {
        reload(with: [items])
    }
}

open class StoreArrayDatasource<Cell: GuidedCell>: StoreArrayCollectionDatasource<Cell.Model, Cell> where Cell: UICollectionViewCell {}
