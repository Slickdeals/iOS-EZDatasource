//
//  ArrayDataProvider.swift
//  GenericDataSource

import UIKit

open class ArrayDataProvider<Model>: ArrayProvider {
    // MARK: - Internal Properties
    
    public typealias ItemType = Model
    
    public var items: [[ItemType]] = []
    
    // MARK: - Lifecycle
    public required init(array: [[ItemType]]) {
        items = array
    }
}

