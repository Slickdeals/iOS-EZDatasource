//
//  ArrayStore.swift
//  EZDatasources
//
//  Created by Dominic Rodriquez on 11/27/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation

public class ArrayStore<Item>: Observable {
    
    public struct Context: Reducible {
        
        public typealias Model = Item
        
        public var items: [[Item]] = [[]]
        public var allItems: [Item] {
            return items.reduce([Item]()) { return $0 + $1 }
        }
    }
    
    public enum Update {
        case addItems(items: [Item], toSection: Int)
        case addItem(item: Item, toSection: Int)
        case updateItem(at: IndexPath, withItem: Item)
        case updateAll(with: [[Item]])
        case removeItem(at: IndexPath)
        case removeAll
    }
    
    var items: [[Item]] {
        get {
            return value.items
        }
        set {
            value.items = newValue
        }
    }
    
    var allItems: [Item] {
        return value.allItems
    }
    
    public typealias Action = Context.Action
    public typealias Model = ArrayStore<Item>.Context
    
    public var observers: [String: ObserverWrapper<Context, Action>] = [:]
    
    public var value: Context = Context()
    
    public init(items: [[Item]]) {
        self.items = items
    }
    
    public convenience init(items: [Item]) {
        self.init(items: [items])
    }
    
    public func perform(action: Action) {
        
        // assign the value to be whatever the updated value is, which is supplied by the update function
        let valueBeforeUpdate = value
        value = update(with: action, from: valueBeforeUpdate)
        
        print("observers: perform - \(observers.count)")
        
        // now that we have the new value and the old value, notify each observer
        observers.values.forEach { observer in
            observer.observableDidChange(from: valueBeforeUpdate, to: value, wasTriggeredBy: action)
        }
    }
}
