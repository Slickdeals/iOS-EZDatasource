//
//  CollectionDataSource+Reactive.swift
//  EZDatasources
//
//  Created by Dominic Rodriquez on 7/13/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit

open class CollectionArrayReactiveDatasource<Model, Cell: UICollectionViewCell>:
    ReactiveCollectionDatasource<ReactiveArrayDataProvider<Model>, Cell>
    where Cell: EZCell, Cell.Model == Model
{
    
    public typealias Provider = ReactiveArrayDataProvider<Model>
    // MARK: - Lifecycle
    public convenience init(collectionView: UICollectionView, array: [Model] = [], cellDelegate: Cell.Delegate? = nil) {
        self.init(collectionView: collectionView, array: [array], cellDelegate: cellDelegate)
    }
    
    public override init(collectionView: UICollectionView, provider: Provider, cellDelegate: Cell.Delegate? = nil) {
        super.init(collectionView: collectionView, provider: provider, cellDelegate: cellDelegate)
    }
    
    public required init(collectionView: UICollectionView, array: [[Model]] = [], cellDelegate: Cell.Delegate? = nil) {
        let provider = ReactiveArrayDataProvider<Model>()
        super.init(collectionView: collectionView, provider: provider, cellDelegate: cellDelegate)
    }
    
    // MARK: - Public Methods
    open func item(at indexPath: IndexPath) -> Model? {
        return provider.item(at: indexPath)
    }
    
    open func updateItem(at indexPath: IndexPath, value: Model) {
        provider.updateItem(at: indexPath, value: value)
        DispatchQueue.main.async { self.collectionView.reloadItems(at: [indexPath]) }
    }
    
    open func reload(with items: [Model]) {
        provider.publish(event: ProviderEvent.didCompleteLoading.rawValue, with: items)
    }
}

open class EZCollectionArrayReactiveDatasource<Provider: ExplicitEventBroker & CollectionDataProvider, Cell: EZCell>: CollectionArrayReactiveDatasource<Cell.Model, Cell> where Cell: UICollectionViewCell {}
