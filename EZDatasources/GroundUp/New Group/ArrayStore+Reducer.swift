//
//  ArrayStore+Reducer.swift
//  EZDatasources
//
//  Created by Dominic Rodriquez on 11/27/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation

extension ArrayStore.Context {
    
    public typealias Action = ArrayStore<Item>.Update
    
    public func reduced(by action: Action, from oldValue: ArrayStore.Context) -> ArrayStore.Context {

        var newValue = oldValue

        switch action {
        case .addItems(let items, let section):
            newValue.items[section] = newValue.items[section] + items

        case .addItem(let item, let section):
            newValue.items[section] = newValue.items[section] + [item]

        case .updateItem(let indexPath, let item):
            let position = max(indexPath.item, indexPath.row)
            newValue.items[indexPath.section][position] = item
            guard indexPath.section >= 0 && indexPath.section < items.count,
                position < items[indexPath.section].count,
                position >= 0
                else { return oldValue }
            newValue.items[indexPath.section][position] = item

        case .updateAll(let newItems):
            newValue.items = newItems

        case .removeItem(let indexPath):
            let position = max(indexPath.item, indexPath.row)
            newValue.items[indexPath.section].remove(at: position)

        case .removeAll:
            newValue.items.removeAll()
        }

        return newValue
    }
}
