//
//  CollectionDataSource.swift
//  GenericDataSource

import UIKit

public typealias CollectionItemSelectionHandlerType = (IndexPath) -> Void

open class CollectionDataSource<Store: CollectionInterface, Cell: UICollectionViewCell>: NSObject, UICollectionViewDataSource, UICollectionViewDelegate
where Cell: GuidedCell, Store.CollectionElement == Cell.Model {
    
    let subscriberID: String = UUID().uuidString
    
    // MARK: - Delegates
    open var selectionDelegate: CollectionItemSelectionHandlerType?
    open var cellDelegate: Cell.Interactor? = nil
    
    // MARK: - Private Properties
    public var store: Store
    public var collectionView: UICollectionView? 
    
    // MARK: - Initializer
    public init(backedBy store: Store, for collectionView: UICollectionView? = nil, cellCommunicatesWith delegate: Cell.Interactor? = nil) {
        self.store = store
        super.init()
        guard let validCollectionView = collectionView else { return }
        drive(contentsOf: validCollectionView, cellCommunicatesWith: cellDelegate)
    }
    
    // MARK: - Drive collectionViewData
    public func drive(contentsOf targetCollectionView: UICollectionView, cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) {
        cellDelegate = interactionDelegate
        collectionView = targetCollectionView
        targetCollectionView.dataSource = self
        targetCollectionView.delegate = self
        if let cellNib = Cell.nib, Cell.registerNib {
            targetCollectionView.register(cellNib.nibFile, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        }
        else {
            guard Cell.storyboardIdentifier == nil else { return }
            targetCollectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return store.numberOfSections()
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.numberOfItems(in: section)
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell
            else { return UICollectionViewCell() }
        let item = store.item(at: indexPath)
        cell.configure(with: item, at: indexPath, communicatesWith: cellDelegate)
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
