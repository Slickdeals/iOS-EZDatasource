//
//  CollectionDataProvider.swift
//  GenericDataSource

import UIKit

public enum ProviderStatus {
    case goingToFetchSomeData
    case allDoneFetchingData
    case didUpdateItems(atIndexPaths: [IndexPath])
    case didUpdateAllItems
}

public protocol CollectionDataProvider {
    associatedtype Model
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> Model?
    
    func updateItem(at indexPath: IndexPath, value: Model)
}
