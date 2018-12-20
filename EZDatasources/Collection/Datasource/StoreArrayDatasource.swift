//
//  CollectionArrayDataSource.swift
//  GenericDataSource


import UIKit

open class StoreArrayCollectionDatasource<Model, Cell: UICollectionViewCell>: CollectionDataSource<ArrayStore<Model>, Cell>, Observable
    where Cell: EZCell, Cell.Model == Model {
    
    public typealias Action = ArrayStore<Model>.Action
    public typealias Element = ArrayStore<Model>.Element
    
    public var observers: [String: ObserverWrapper<Element>] {
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
    
    // MARK: - Lifecycle
    public convenience init(collectionView: UICollectionView, array: [Model] = [], cellDelegate: Cell.Delegate? = nil) {
        self.init(collectionView: collectionView, array: [array], cellDelegate: cellDelegate)
    }
    
    public required init(collectionView: UICollectionView, array: [[Model]] = [], cellDelegate: Cell.Delegate? = nil) {
        let store = ArrayStore<Model>(items: array)
        super.init(collectionView: collectionView, store: store, cellDelegate: cellDelegate)
    }
    
    override public init(collectionView: UICollectionView, store: ArrayStore<Model>, cellDelegate: Cell.Delegate? = nil) {
        super.init(collectionView: collectionView, store: store, cellDelegate: cellDelegate)
    }
    
    // MARK: - Public Methods
    open func item(at indexPath: IndexPath) -> Model? {
        return store.item(at: indexPath)
    }
    
    open func updateItem(at indexPath: IndexPath, value: Model) {
        store.perform(action: .updateItem(at: indexPath, withItem: value))
        collectionView.reloadItems(at: [indexPath])
    }
    
    open func reload(with items: [[Model]]) {
        store.perform(action: .updateAll(with: items))
    }
    
    open func reload(with items: [Model]) {
        reload(with: [items])
    }
}

open class StoreArrayDatasource<Cell: EZCell>: StoreArrayCollectionDatasource<Cell.Model, Cell> where Cell: UICollectionViewCell {}

//open class StoreDatasource<Model, Cell: UICollectionViewCell>: CollectionDataSource<ArrayStore<Model>, Cell> where Cell: EZCell, Cell.Model == Model {
//
//    typealias StoreType = ArrayStore<Model>
//
//    // MARK: - Lifecycle
//    public convenience init(collectionView: UICollectionView, array: [Model] = [], cellDelegate: Cell.Delegate? = nil) {
//        self.init(collectionView: collectionView, array: [array], cellDelegate: cellDelegate)
//    }
//
//    public required init(collectionView: UICollectionView, array: [[Model]] = [], cellDelegate: Cell.Delegate? = nil) {
//        var store = ArrayStore<Model>(items: array)
//        super.init(collectionView: collectionView, store: store, cellDelegate: cellDelegate)
//        store.startObserving { update in
//
//        }
//    }
//}

//open class ArrayStoreDatasource<Cell: EZCell>: InternalArrayStoreDatasource<Cell.Model, Cell>, Observable where Cell: UICollectionViewCell {
//
//    public var value: ArrayStore<Cell.Model> {
//
//    }
//
//    public var observers: [String : ObserverWrapper<ArrayStore<Cell.Model>>]
//
//
//    public typealias Element = ArrayStore<Cell.Model>
//    public typealias Action = ArrayUpdate<Cell.Model>
//
//}

