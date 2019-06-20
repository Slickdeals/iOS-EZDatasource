//
//  COG.swift
//  COGuide
//
//  Created by Dominic Rodriquez on 12/20/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit

public protocol GuidedModel {}

public extension GuidedModel {
    
    static func makeStore(with items: [Self] = []) -> ArrayStore<Self> {
        return ArrayStore<Self>(items: items)
    }
    
    static func makeDatasource<Cell: GuidedCell>(for cellType: Cell.Type) -> StoreArrayDatasource<Cell>
        where Cell.Model == Self {
            return StoreArrayDatasource<Cell>(backedBy: Self.makeStore())
    }
    
    static func makeDatasource<Cell: GuidedCell>(
        for cellType: Cell.Type,
        backedBy store: ArrayStore<Cell.Model>) -> StoreArrayDatasource<Cell>
        where Cell.Model == Self {
            return StoreArrayDatasource<Cell>(backedBy: store)
    }
    
    static func makeDatasource<Cell: GuidedCell>(
        for cellType: Cell.Type,
        backedBy store: ArrayStore<Cell.Model> = Self.makeStore(),
        toDriveCollectionView collectionView: UICollectionView,
        cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) -> StoreArrayDatasource<Cell>
        where Cell.Model == Self {
            return StoreArrayDatasource<Cell>(backedBy: store, toDriveCollectionView: collectionView, cellCommunicatesWith: interactionDelegate)
    }
    
    static func makeDatasource<Cell: GuidedCell>(
        for cellType: Cell.Type,
        backedBy store: ArrayStore<Cell.Model> = Self.makeStore(),
        toDriveTableView tableView: UITableView,
        cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) -> StoreArrayDatasource<Cell>
        where Cell.Model == Self {
            return StoreArrayDatasource<Cell>(backedBy: store, toDriveTableView: tableView, cellCommunicatesWith: interactionDelegate)
    }
}


public extension Array where Element == GuidedModel {
    
    func makeStore() -> ArrayStore<Element> {
        return ArrayStore<Element>(items: self)
    }
    
    func makeDatasource<CellType: GuidedCell>(for cellType: CellType.Type) -> StoreArrayDatasource<CellType>
        where CellType.Model == Element {
            return StoreArrayDatasource<CellType>(backedBy: makeStore())
    }
    
    func makeDatasource<CellType: GuidedCell>(
        toDriveCollectionView collectionView: UICollectionView,
        cellCommunicatesWith interactionDelegate: CellType.Interactor? = nil) -> StoreArrayDatasource<CellType>
        where CellType.Model == Element {
            return StoreArrayDatasource<CellType>(backedBy: [self], toDriveCollectionView: collectionView, cellCommunicatesWith: interactionDelegate)
    }
    
    func makeDatasource<Cell: GuidedCell>(
        for cellType: Cell.Type,
        toDriveCollectionView collectionView: UICollectionView,
        cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) -> StoreArrayDatasource<Cell>
        where Cell.Model == Element {
            return StoreArrayDatasource<Cell>(backedBy: [self], toDriveCollectionView: collectionView, cellCommunicatesWith: interactionDelegate)
    }
    
    func makeDatasource<Cell: GuidedCell>(
        for cellType: Cell.Type,
        toDriveTableView tableView: UITableView,
        cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) -> StoreArrayDatasource<Cell>
        where Cell.Model == Element {
            return StoreArrayDatasource<Cell>(backedBy: [self], toDriveTableView: tableView, cellCommunicatesWith: interactionDelegate)
    }
    
    func makeDatasource<CellType: GuidedCell>(
        for tableView: UITableView,
        cellCommunicatesWith interactionDelegate: CellType.Interactor? = nil) -> StoreArrayDatasource<CellType>
        where CellType.Model == Element {
            return StoreArrayDatasource<CellType>(backedBy: [self], toDriveTableView: tableView, cellCommunicatesWith: interactionDelegate)
    }
}
