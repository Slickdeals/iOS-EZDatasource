//
//  CollectionDataSource+Reactive.swift
//  EZDatasources
//
//  Created by Dominic Rodriquez on 7/13/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit

//open class CollectionArrayReactiveDatasource<Model, Cell: UICollectionViewCell>:
//ReactiveCollectionDatasource<ReactiveArrayDataStore<Model>, Cell> {}

//open class CollectionArrayReactiveDatasource<Model, Cell: UICollectionViewCell>:
//    ReactiveCollectionDatasource<ReactiveArrayDataStore<Model>, Cell>
//    where Cell: EZCell, Cell.Model == Model
//{
//
//    public typealias Store = ReactiveArrayDataStore<Model>
//    // MARK: - Lifecycle
//    public convenience init(collectionView: UICollectionView, array: [Model] = [], cellDelegate: Cell.Delegate? = nil) {
//        self.init(collectionView: collectionView, array: [array], cellDelegate: cellDelegate)
//    }
//
//    public override init(collectionView: UICollectionView, store: Store, cellDelegate: Cell.Delegate? = nil) {
//        super.init(collectionView: collectionView, store: store, cellDelegate: cellDelegate)
//    }
//
//    public required init(collectionView: UICollectionView, array: [[Model]] = [], cellDelegate: Cell.Delegate? = nil) {
//        let store = ReactiveArrayDataStore<Model>()
//        super.init(collectionView: collectionView, store: store, cellDelegate: cellDelegate)
//    }
//
//    // MARK: - Public Methods
//    open func item(at indexPath: IndexPath) -> Model? {
//        return store.item(at: indexPath)
//    }
//
//    open func updateItem(at indexPath: IndexPath, value: Model) {
//        store.updateItem(at: indexPath, value: value)
//        DispatchQueue.main.async { self.collectionView.reloadItems(at: [indexPath]) }
//    }
//
//    open func reload(with items: [Model]) {
//        store.publish(event: StoreEvent.didCompleteLoading.rawValue, with: items)
//    }
//}
//
//open class EZCollectionArrayReactiveDatasource<Store: ExplicitEventBroker & CollectionDataStore, Cell: EZCell>: CollectionArrayReactiveDatasource<Cell.Model, Cell> where Cell: UICollectionViewCell {}

//open class EZCollectionArrayReactiveDatasource<Store, Cell: EZCell>: CollectionArrayReactiveDatasource<Cell.Model, Cell> where Cell: UICollectionViewCell {}
