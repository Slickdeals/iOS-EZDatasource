//
//  ArrayDataStore.swift
//  GenericDataSource

import UIKit

public protocol NamedEvent {
    var eventName: String { get set }
    
}

//public struct AStore<Model: Reducible>: ObservableReducer {
//    
//    public typealias Element = Model
//    
//    enum Update {
//        case ite
//    }
//    
//    public typealias Action = Model.ReduceAction
//    
//    /**
//     This value will always be set to the state of the previous value of the store every time the store updates.
//     - You will never modify this value
//     */
//    public var previousValue: Model
//    
//    /**
//     This is the current value of the store, which is an instance of the Model the entity this store manages.
//     Your entity should have all of the state and propeties you want to manage for your store.
//     - You will never modify this value
//     */
//    public var value: Model
//    
//    /**
//     This is the collection of observers currently watching for changes
//     */
//    public var observers: [String: ObserverWrapper<Model>] = [:]
//    
//    /**
//     Initializes the store of the specified type with the initial value you provide
//     
//     - Until the store is updated, `value` and `previousValue` will be equal
//     
//     - parameters:
//     - initialValue: this is the instance of your Model Type that the store will initially be set to
//     
//     */
//    public init(initialValue: Model) {
//        value = initialValue
//        previousValue = initialValue
//    }
//    
//}

//open class ArrayDataStore<Model>: ArrayStore {
//
//    // MARK: - Internal Properties
//    public typealias FetchAllSuccess = ([Model]) -> Void
//    public typealias FetchOneSuccess = (Model, IndexPath) -> Void
//    public typealias FetchFailure = (StoreError) -> Void
//
//    public var items: [ModelCollection] = []
//
//    // MARK: - Lifecycle
//    public required init(array: ModelCollection) {
//        items = regroupIntoSections(given: array)
//    }
//
//    public convenience init(array: ModelSectionedCollection = []) {
//        let items: [Model] = array.flatMap { $0 }
//        self.init(array: items)
//    }
//
//    public func loadItem(at indexPath: IndexPath) {
//        fetch(didLoadSuccessfully: self.fetchSuccess, didFail: self.fetchDidFail)
//    }
//
//    public func loadAll() {
//        fetchAll(didLoadSuccessfully: self.fetchAllSuccess, didFail: self.fetchDidFail)
//    }
//
//    open func fetch(didLoadSuccessfully: FetchOneSuccess, didFail: FetchFailure) {
//
//    }
//
//    open func fetchAll(didLoadSuccessfully: FetchAllSuccess, didFail: FetchFailure) {
//
//    }
//
//    private func fetchSuccess(fetchResults: Model, indexPath: IndexPath) {
//        updateItem(at: indexPath, value: fetchResults)
//    }
//
//    private func fetchAllSuccess(fetchResults: [Model]) {
//        reload(with: fetchResults)
//    }
//
//    private func fetchDidFail(error: StoreError) {
//
//    }
//}
