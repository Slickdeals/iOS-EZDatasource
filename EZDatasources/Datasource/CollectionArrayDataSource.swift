//
//  CollectionArrayDataSource.swift
//  GenericDataSource


import UIKit

open class CollectionArrayDataSource<Model, Cell: UICollectionViewCell>: CollectionDataSource<ArrayDataProvider<Model>, Cell>
    where Cell: EZCell, Cell.Model == Model
{
    
    // MARK: - Lifecycle
    public convenience init(collectionView: UICollectionView, array: [Model] = [], cellDelegate: Cell.Delegate? = nil) {
        self.init(collectionView: collectionView, array: [array], cellDelegate: cellDelegate)
    }
    
    public init(collectionView: UICollectionView, array: [[Model]] = [], cellDelegate: Cell.Delegate? = nil) {
        let provider = ArrayDataProvider(array: array)
        super.init(collectionView: collectionView, provider: provider, cellDelegate: cellDelegate)
    }
    
    // MARK: - Public Methods
    open func item(at indexPath: IndexPath) -> Model? {
        return provider.item(at: indexPath)
    }
    
    open func updateItem(at indexPath: IndexPath, value: Model) {
        provider.updateItem(at: indexPath, value: value)
        collectionView.reloadItems(at: [indexPath])
    }
    
    open func reload(with items: [[Model]]) {
        provider.items = items
    }
    
    open func reload(with items: [Model]) {
        reload(with: [items])
    }
}

open class EZCollectionArrayDatasource<Cell: EZCell>: CollectionArrayDataSource<Cell.Model, Cell> where Cell: UICollectionViewCell {}
