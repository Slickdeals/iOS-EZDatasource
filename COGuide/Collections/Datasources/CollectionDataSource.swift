//
//  CollectionDataSource.swift
//  GenericDataSource

import UIKit

public typealias CollectionItemSelectionHandlerType = (IndexPath) -> Void

//open class TableDataSource<Store: CollectionInterface, Cell: UITableViewCell>: NSObject, UITableViewDataSource, UITableViewDelegate
//where Cell: GuidedCell, Store.CollectionElement == Cell.Model {
//
//}

open class CollectionDataSource<Store: CollectionInterface, Cell: UICollectionViewCell>: NSObject, UICollectionViewDataSource, UICollectionViewDelegate
where Cell: GuidedCell, Store.CollectionElement == Cell.Model {
    
    let subscriberID: String = UUID().uuidString
    
    // MARK: - Delegates
    open var selectionDelegate: CollectionItemSelectionHandlerType?
    open var cellDelegate: Cell.Interactor? = nil
    
    // MARK: - Private Properties
    public var store: Store
    public var collectionView: UICollectionView?
    public var tableView: UITableView?
    
    // MARK: - Initializer
    
    /**
     Initializes the datasource with an initial store
     
     - parameters:
        - store: store that will be internally managed by and updated through the datasource.
                 The data in the store is what will be used to populate each cell of the collection/table view
     */
    public init(backedBy store: Store) {
        self.store = store
        super.init()
    }
    
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

public extension CollectionDataSource {
    
    
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
}

protocol StandardCollectionCell {
    
    // I need a way to get either UITableViewCell or UICollectionViewCell back from a standard protocol depending on which one I am
    // I would need to know ahead of time which cell I was getting
    
    // so from the datasource, if I only know the protocol type, how would I specify which one
    
    // the protocol could have generic function that either takes a collection view
    
    // could create a dequeable protocol, extend collectionview and tableview with it, and it specifies which type it dequeues,
    
}
