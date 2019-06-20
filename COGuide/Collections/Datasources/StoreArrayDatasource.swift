//
//  CollectionArrayDataSource.swift
//  GenericDataSource


import UIKit

public struct DealTapHandler {
    public func didTap(deal: Deal) {
        print(deal)
    }
}
public class Deal: GuidedModel {
    public var title: String
    public var price: String
    
    public static var allStaticDeals: [Deal] = [Deal(), Deal(), Deal()]
    
    public init(title: String = "awesome deal", price: String = "cheap ass price") {
        self.title = title
        self.price = price
    }
}
public class DealListCell: GuidedTableViewCell<Deal, DealTapHandler>, CellGuide {
    
    @IBOutlet weak var dealTitle: UILabel!
    @IBOutlet weak var dealPrice: UILabel!
    
    @IBAction func didTapDeal(_ sender: UIButton) {
        interactor?.didTap(deal: model!)
    }
    
    public func didUpdateModel(with updatedModel: Deal) {
        dealTitle.text = updatedModel.title
        dealPrice.text = updatedModel.price
    }
}
//So now you just add some properties to your model definition, then you can use those to update the outlets in the cell
//This file was deleted.
//So now to make your datasource you just start typing datasource from your model, and you can either supply everything up front or just give it the essentials
//This file was deleted.
//So I need to supply what cell this datasource uses, which is any GuidedCell, and then specify which type of collection it’s for

// there are actually a few different ways you can do this

public class DealViewController: UIViewController {
    
    public let datasourceFromModel = Deal.makeDatasource(for: DealListCell.self)
    public let dealTapHandler = DealTapHandler()
    //public let datasourceFromExistingArray = Deal.allStaticDeals.makeDatasource(for: DealListCell.self)
    //public let datasourceFromCell = DealListCell.makeDatasource()
    
    @IBOutlet weak var tableView: UITableView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        datasourceFromModel.startObserving { update in
            switch update.triggedBy {
            case .addItem(let addedItem, let sectionItemAddedTo):
                print(addedItem)
                print(sectionItemAddedTo)
                // do special work
                break
            default:
                self.tableView.reloadData()
                break
            }
        }
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        datasourceFromModel.drive(contentsOf: self.tableView, cellCommunicatesWith: self.dealTapHandler)
    }
    
    func didUpdateDeals() {
        datasourceFromModel.publish(action: .updateAll(with: [Deal.allStaticDeals]))
    }
}

open class StoreArrayCollectionDatasource<Model, Cell: GuidedCell>: CollectionDataSource<ArrayStore<Model>, Cell>, Observable where Cell.Model == Model {
    
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
                            toDriveCollectionView collectionView: UICollectionView? = nil,
                            cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) {
        self.init(backedBy: [array], toDriveCollectionView: collectionView, cellCommunicatesWith: interactionDelegate)
    }
    
    public convenience init(backedBy array: [Model] = [],
                            toDriveTableView tableView: UITableView? = nil,
                            cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) {
        self.init(backedBy: [array], toDriveTableView: tableView, cellCommunicatesWith: interactionDelegate)
    }
    
    public required init(backedBy array: [[Model]] = [],
                         toDriveCollectionView collectionView: UICollectionView? = nil,
                         cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) {
        guard let validCollection = collectionView else {
            super.init(backedBy: ArrayStore<Model>(items: array))
            cellDelegate = interactionDelegate
            return
        }
        super.init(backedBy: ArrayStore<Model>(items: array), toDriveCollectionView: validCollection, cellCommunicatesWith: interactionDelegate)
    }
    
    public required init(backedBy array: [[Model]] = [],
                         toDriveTableView tableView: UITableView? = nil,
                         cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) {
        guard let validCollection = tableView else {
            super.init(backedBy: ArrayStore<Model>(items: array))
            cellDelegate = interactionDelegate
            return
        }
        super.init(backedBy: ArrayStore<Model>(items: array), toDriveTableView: validCollection, cellCommunicatesWith: interactionDelegate)
    }
    
    override public init(backedBy store: ArrayStore<Model>,
                         toDriveCollectionView collectionView: UICollectionView? = nil,
                         cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) {
        guard let validCollection = collectionView else {
            super.init(backedBy: store)
            cellDelegate = interactionDelegate
            return
        }
        super.init(backedBy: store, toDriveCollectionView: validCollection, cellCommunicatesWith: interactionDelegate)
    }
    
    override public init(backedBy store: ArrayStore<Model>,
                         toDriveTableView tableView: UITableView? = nil,
                         cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) {
        guard let validCollection = tableView else {
            super.init(backedBy: store)
            cellDelegate = interactionDelegate
            return
        }
        super.init(backedBy: store, toDriveTableView: validCollection, cellCommunicatesWith: interactionDelegate)
    }
    
    override public init(backedByArray array: StoreType.CollectionType) {
        super.init(backedByArray: array)
    }
    
    override public init(backedBy store: StoreType) {
        super.init(backedBy: store)
    }
    
//    public init(backedByArray array: Store.CollectionType) {
//        super.init(backedByArray: array)
//    }
    
    // MARK: - Public Methods
    open func item(at indexPath: IndexPath) -> Model? {
        return store.item(at: indexPath)
    }
    
    open func updateItem(at indexPath: IndexPath, value: Model) {
        store.publish(action: .updateItem(at: indexPath, withItem: value))
        collectionView?.reloadItems(at: [indexPath])
    }
    
    open func reload(with items: [[Model]]) {
        store.publish(action: .updateAll(with: items))
    }
    
    open func reload(with items: [Model]) {
        reload(with: [items])
    }
}

open class StoreArrayDatasource<Cell: GuidedCell>: StoreArrayCollectionDatasource<Cell.Model, Cell> {}
