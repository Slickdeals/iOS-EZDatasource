//
//  CollectionDataProvider.swift
//  GenericDataSource

import UIKit

public protocol CollectionDataProvider {
    associatedtype Model
    typealias ModelCollection = [Model]
    typealias ModelSectionedCollection = [ModelCollection]
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> Model?
    
    func loadItem(at indexPath: IndexPath)
    func loadAll()
    
    func updateItem(at indexPath: IndexPath, value: Model)
}
