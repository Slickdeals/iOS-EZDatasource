//
//  GuidedCell+MakeDatasource.swift
//  COGuide
//
//  Created by Dominic Rodriquez on 12/20/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit

public extension GuidedCell where Self: UICollectionViewCell {
    
    static func makeDatasource(backedBy items: [Model] = []) -> StoreArrayDatasource<Self> {
        return StoreArrayDatasource<Self>(backedByArray: items)
    }
    
    // MARK: - convenience function to create a datasource for a collectionView by providing the array of items, collectionView, and optional delegate for the cells
    static func makeDatasource(backedBy items: [Model] = [],
                               toDriveCollectionView collectionView: UICollectionView,
                               cellCommunicatesWith interactionDelegate: Interactor? = nil) -> StoreArrayDatasource<Self> {
        return StoreArrayDatasource<Self>(backedBy: [items], toDriveCollectionView: collectionView, cellCommunicatesWith: interactionDelegate)
    }
    
    static func makeDatasource(backedBy store: ArrayStore<Model>,
                               toDriveCollectionView collectionView: UICollectionView,
                               cellCommunicatesWith interactionDelegate: Interactor? = nil) -> StoreArrayDatasource<Self> {
        return StoreArrayDatasource<Self>(backedBy: store, toDriveCollectionView: collectionView, cellCommunicatesWith: interactionDelegate)
    }
    
    
    // MARK: - convenience function to create a datasource for a tableView by providing the array of items, tableView, and optional delegate for the cells
    static func makeDatasource(backedBy items: [Model] = [],
                               toDriveTableView tableView: UITableView,
                               cellCommunicatesWith interactionDelegate: Interactor? = nil) -> StoreArrayDatasource<Self> {
        return StoreArrayDatasource<Self>(backedBy: [items], toDriveTableView: tableView, cellCommunicatesWith: interactionDelegate)
    }
    
    
    static func makeDatasource(backedBy store: ArrayStore<Model>,
                               toDriveTableView tableView: UITableView,
                               cellCommunicatesWith interactionDelegate: Interactor? = nil) -> StoreArrayDatasource<Self> {
        return StoreArrayDatasource<Self>(backedBy: store, toDriveTableView: tableView, cellCommunicatesWith: interactionDelegate)
    }
}
