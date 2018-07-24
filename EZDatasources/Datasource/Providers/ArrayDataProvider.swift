//
//  ArrayDataProvider.swift
//  GenericDataSource

import UIKit

public protocol NamedEvent {
    var eventName: String { get set }
    
}

open class ArrayDataProvider<Model>: ArrayProvider {
    
    // MARK: - Internal Properties
    public typealias FetchAllSuccess = ([Model]) -> Void
    public typealias FetchOneSuccess = (Model, IndexPath) -> Void
    public typealias FetchFailure = (ProviderError) -> Void
    
    public var items: [ModelCollection] = []
    
    // MARK: - Lifecycle
    public required init(array: ModelCollection) {
        items = regroupIntoSections(given: array)
    }
    
    public convenience init(array: ModelSectionedCollection = []) {
        let items: [Model] = array.flatMap { $0 }
        self.init(array: items)
    }
    
    public func loadItem(at indexPath: IndexPath) {
        fetch(didLoadSuccessfully: self.fetchSuccess, didFail: self.fetchDidFail)
    }
    
    public func loadAll() {
        fetchAll(didLoadSuccessfully: self.fetchAllSuccess, didFail: self.fetchDidFail)
    }
    
    open func fetch(didLoadSuccessfully: FetchOneSuccess, didFail: FetchFailure) {
        
    }
    
    open func fetchAll(didLoadSuccessfully: FetchAllSuccess, didFail: FetchFailure) {
        
    }
    
    private func fetchSuccess(fetchResults: Model, indexPath: IndexPath) {
        updateItem(at: indexPath, value: fetchResults)
    }
    
    private func fetchAllSuccess(fetchResults: [Model]) {
        reload(with: fetchResults)
    }
    
    private func fetchDidFail(error: ProviderError) {
        
    }
}
