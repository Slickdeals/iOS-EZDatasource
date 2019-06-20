//
//  CollectionDataSource.swift
//  GenericDataSource

import UIKit

public typealias CollectionItemSelectionHandlerType = (IndexPath) -> Void

public enum Either<A, B> {
    case left(A)
    case right(B)
}

public enum EitherOf<TableView, CollectionView> {
    case selectTable(TableView)
    case selectCollectionView(CollectionView)
}

// Content Destination
// Content Container

enum ContentContainer {
    case tableView(tableView: UITableView)
    case collectionView(collectionView: UICollectionView)
}

public protocol AutosizingCell {
    static var estimatedHeight: CGFloat { get set }
    var cellHeight: CGFloat { get set }
}

public protocol FixedHeightCell {
    static var cellHeight: CGFloat { get set }
}

//public class CustomFlowLayoutDelegate: NSObject, UICollectionViewDelegateFlowLayout {
//    var collectionViewDelegate: UICollectionViewDelegate
//    var flowDelegate: COFlowLayoutDelegate
//
//    public init(collectionViewDelegate: UICollectionViewDelegate, flowLayoutDelegate: COFlowLayoutDelegate) {
//        self.collectionViewDelegate = collectionViewDelegate
//        self.flowDelegate = flowLayoutDelegate
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//
//    }
//}

@objc public protocol COFlowLayoutDelegate {
    @available(iOS 6.0, *)
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    
    @available(iOS 6.0, *)
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    
    @available(iOS 6.0, *)
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    
    @available(iOS 6.0, *)
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    
    @available(iOS 6.0, *)
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    
    @available(iOS 6.0, *)
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
}

enum CollectionViewSpec {
    case nothingFancy
    case useFlowLayoutDelegate(flowDelegate: COFlowLayoutDelegate)
    case useCustomLayout(layout: UICollectionViewFlowLayout)
}

// I want it to be .UICollectionViewSpec(./.useCustomLayout/.useFlowLayoutDelegate)
typealias UICollectionViewSpec = (UICollectionView.Type, Either<UICollectionViewDelegateFlowLayout.Type, UICollectionViewFlowLayout.Type>?)

open class CollectionDataSource<Store: CollectionInterface, Cell: GuidedCell>: NSObject,
    UICollectionViewDataSource, UICollectionViewDelegate,
    UITableViewDataSource, UITableViewDelegate
    where Store.CollectionElement == Cell.Model {
    
    public typealias StoreType = Store
    
    let subscriberID: String = UUID().uuidString
    
    // MARK: - Delegates
    open var selectionDelegate: CollectionItemSelectionHandlerType?
    open var cellDelegate: Cell.Interactor? = nil
    
    // MARK: - Private Properties
    public var store: Store
    
    public var reusableCellDrivenView: Either<UICollectionView, UITableView>?
    
    public var collectionView: UICollectionView? {
        switch reusableCellDrivenView {
        case .left(let collectionView)?: return collectionView
        default: return nil
        }
    }
    public var tableView: UITableView? {
        switch reusableCellDrivenView {
        case .right(let tableView)?: return tableView
        default: return nil
        }
    }
    
    // MARK: - Initializer
    
    /**
     Initializes the datasource with an initial store
     
     - parameters:
        - store: store that will be internally managed by and updated through the datasource.
                 The data in the store is what will be used to populate each cell of the collection/table view
     
     - Postcondition:
        - the `drive` method must be called at some point after being initialized in order for the datasource
          to be connected to a collection/table view.
     */
    public init(backedBy store: Store) {
        self.store = store
        super.init()
    }
    
    /**
     Initializes the datasource with an initial store
     
     - parameters:
     - array: used to create the store that will be internally managed by and updated through the datasource.
     The data in the store is what will be used to populate each cell of the collection/table view
     
     - Postcondition:
     - the `drive` method must be called at some point after being initialized in order for the datasource
     to be connected to a collection/table view.
     */
    public init(backedByArray array: Store.CollectionType) {
        self.store = Store.init(items: array)
        super.init()
    }
    
    /**
     Initializes the datasource for use with a UITableView or UICollectionView. Expects a backing store to be provided, which it will use to supply
     
     - parameters:
     - store: store that will be internally managed by and updated through the datasource.
     The data in the store is what will be used to populate each cell of the collection/table view
     - targetCollection: the target collection will either be a UICollectionView or a UITableView. This datasource
     will attach to whichever collection/table view is provided by automatically doing the following:
        - Assign its datasource/delegate properties to this datasource
        - Register the specified cell type for this datasource by registering it via its class, nib, or storyboard (whichever the cell is configured to use)
     
     - delegate: the interaction delegate is an optionally provided handler for instances where you would like to delegate/notify
     an entity outside of the cell when something happens. For instance, if an action in a cell would result in
     navigating to a new location, or fetching some data, you could provide the datasource with an instance of
     the entity that knows how to do those things. Then from within the cell, you'll have access to the delegate,
     and can choose to access it's properties or call it's methods in order to take actions that happen outside of the cell
     */
    public init(backedBy store: Store, toDriveCollectionView collectionView: UICollectionView, cellCommunicatesWith delegate: Cell.Interactor? = nil) {
        self.store = store
        super.init()
        drive(contentsOf: collectionView, cellCommunicatesWith: delegate)
    }
    
    public init(backedBy store: Store, toDriveTableView tableView: UITableView, cellCommunicatesWith delegate: Cell.Interactor? = nil) {
        self.store = store
        super.init()
        drive(contentsOf: tableView, cellCommunicatesWith: delegate)
    }
    
    // MARK: - Attach to table/collection view
    /**
     Attaches the datasource to the targetCollection, which fully sets the collection up to properly display cells with the backing store that was provided
     
     Note: *** You only need to call this method if you did not supply a target collection during initializing ***
     
     - parameters:
     - targetCollection: the target collection will either be a UICollectionView or a UITableView. This datasource
     will attach to whichever collection/table view is provided by automatically doing the following:
         - Assign its datasource/delegate properties to this datasource
         - Register the specified cell type for this datasource by registering it via its class, nib, or storyboard (whichever the cell is configured to use)

     - interactionDelegate: the interaction delegate is an optionally provided handler for instances where you would like to delegate/notify
     an entity outside of the cell when something happens. For instance, if an action in a cell would result in
     navigating to a new location, or fetching some data, you could provide the datasource with an instance of
     the entity that knows how to do those things. Then from within the cell, you'll have access to the delegate,
     and can choose to access it's properties or call it's methods in order to take actions that happen outside of the cell
     */
    private func drive(contentsOf targetCollection: Either<UICollectionView, UITableView>, cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) {
        cellDelegate = interactionDelegate
        reusableCellDrivenView = targetCollection
        switch targetCollection {
        case .left(let targetCollectionView):
            targetCollectionView.dataSource = self
            targetCollectionView.delegate = self
            guard let cellNib = Cell.nib, Cell.registerNib else {
                guard Cell.storyboardIdentifier == nil else { return }
                return targetCollectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
            }
            targetCollectionView.register(cellNib.nibFile, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        case .right(let targetTableView):
            targetTableView.dataSource = self
            targetTableView.delegate = self
            guard let cellNib = Cell.nib, Cell.registerNib else {
                guard Cell.storyboardIdentifier == nil else { return }
                return targetTableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
            }
            targetTableView.register(cellNib.nibFile, forCellReuseIdentifier: Cell.reuseIdentifier)
        }
    }
    
    public func drive(contentsOf collectionView: UICollectionView, cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) {
        let wrappedCollectionView = Either<UICollectionView, UITableView>.left(collectionView)
        drive(contentsOf: wrappedCollectionView, cellCommunicatesWith: interactionDelegate)
    }
    
    public func drive(contentsOf tableView: UITableView, cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) {
        let wrappedTableView = Either<UICollectionView, UITableView>.right(tableView)
        drive(contentsOf: wrappedTableView, cellCommunicatesWith: interactionDelegate)
    }
    
    // MARK: - UICollectionViewDataSource
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return store.numberOfSections()
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.numberOfItems(in: section)
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        do {
            let cellWrapper = try collectionView.sharedDequeueReusableCell(withReusableCellType: Cell.self, for: indexPath)
            let item = store.item(at: indexPath)
            cellWrapper.asGuidedCell.configure(with: item, at: indexPath, communicatesWith: cellDelegate)
            return cellWrapper.asBaseCell
        }
        catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
    // MARK: - UICollectionViewDelegate
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectionDelegate?(indexPath)
    }
    
    // MARK: - UITableViewDelegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionDelegate?(indexPath)
    }
    
    // MARK: - UITableViewDatasource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return store.numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.numberOfItems(in: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        do {
            let cellWrapper = try tableView.sharedDequeueReusableCell(withReusableCellType: Cell.self, for: indexPath)
            let item = store.item(at: indexPath)
            cellWrapper.asGuidedCell.configure(with: item, at: indexPath, communicatesWith: cellDelegate)
            return cellWrapper.asBaseCell
        }
        catch let error {
            fatalError(error.localizedDescription)
        }
    }
}

public extension CollectionDataSource where Cell: FixedHeightCell {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Cell.cellHeight
    }
}
