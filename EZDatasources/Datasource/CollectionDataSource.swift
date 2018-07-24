//
//  CollectionDataSource.swift
//  GenericDataSource

import UIKit

public typealias CollectionItemSelectionHandlerType = (IndexPath) -> Void

open class CollectionDataSource<Provider: CollectionDataProvider, Cell: UICollectionViewCell>: NSObject, UICollectionViewDataSource, UICollectionViewDelegate
where Cell: EZCell, Provider.Model == Cell.Model {
    
    let subscriberID: String = UUID().uuidString
    
    // MARK: - Delegates
    open var selectionDelegate: CollectionItemSelectionHandlerType?
    open var cellDelegate: Cell.Delegate? = nil
    
    // MARK: - Private Properties
    public var provider: Provider
    public let collectionView: UICollectionView
    
    // MARK: - Lifecycle
    public init(collectionView: UICollectionView, provider: Provider, cellDelegate: Cell.Delegate? = nil) {
        self.collectionView = collectionView
        self.provider = provider
        self.cellDelegate = cellDelegate
        super.init()
        setup()
    }
    
    public func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        if let cellNib = Cell.nib, Cell.registerNib {
            collectionView.register(cellNib.nibFile, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        }
        else {
            guard Cell.storyboardIdentifier == nil else { return }
            collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return provider.numberOfSections()
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return provider.numberOfItems(in: section)
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell
            else { return UICollectionViewCell() }
        let item = provider.item(at: indexPath)
        cell.setup(for: item, at: indexPath, with: cellDelegate)
        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
    // MARK: - UICollectionViewDelegate
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectionDelegate?(indexPath)
    }
}

