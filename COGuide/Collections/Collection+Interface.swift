//
//  Collection+Interface.swift
//  EZDatasources
//
//  Created by Dominic Rodriquez on 11/27/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation

public protocol CollectionInterface {
    
    associatedtype CollectionElement
    associatedtype CollectionType: Collection where CollectionType.Element == CollectionElement
    
    init(items: CollectionType)
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> CollectionElement?
    func updateItem(at indexPath: IndexPath, value: CollectionElement)
    
}
