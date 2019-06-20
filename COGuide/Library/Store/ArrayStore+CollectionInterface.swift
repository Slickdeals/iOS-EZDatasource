//
//  ArrayStore+CollectionInterface.swift
//  EZDatasources
//
//  Created by Dominic Rodriquez on 11/27/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation

extension ArrayStore: CollectionInterface {
    
    public typealias CollectionType = [Item]
    
    public func numberOfSections() -> Int {
        return items.count
    }
    
    public func numberOfItems(in section: Int) -> Int {
        guard section >= 0 && section < items.count else { return 0 }
        return items[section].count
    }
    
    public func item(at indexPath: IndexPath) -> Item? {
        let position = max(indexPath.item, indexPath.row)
        guard numberOfItems(in: indexPath.section) > 0,
            position < items[indexPath.section].count,
            position >= 0
            else { return nil }
        return items[indexPath.section][position]
    }
    
    public func updateItem(at indexPath: IndexPath, value: Item) {
        items[indexPath.section][indexPath.row] = value
    }
    
}
