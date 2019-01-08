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
    
    public static func makeStore(with items: [Self] = []) -> ArrayStore<Self> {
        return ArrayStore<Self>(items: items)
    }
    
    public static func makeDatasource<Cell: GuidedCell>(
        for cellType: Cell.Type,
        backedBy store: ArrayStore<Cell.Model> = Self.makeStore(),
        for collectionView: UICollectionView? = nil,
        cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) -> StoreArrayDatasource<Cell>
        where Cell.Model == Self {
            // for: collectionView, cellCommunicatesWith: interactionDelegate
            return StoreArrayDatasource<Cell>(backedBy: store, for: collectionView, cellCommunicatesWith: interactionDelegate)
    }
}


public extension Array where Element == GuidedModel {
    
    public func makeDatasource<CellType: GuidedCell>(
        for collectionView: UICollectionView? = nil,
        cellCommunicatesWith interactionDelegate: CellType.Interactor? = nil) -> StoreArrayDatasource<CellType>
        where CellType.Model == Element {
            return StoreArrayDatasource<CellType>(backedBy: [self], for: collectionView, cellCommunicatesWith: interactionDelegate)
    }
    
    public func makeDatasource<Cell: GuidedCell>(
        for cellType: Cell.Type,
        for collectionView: UICollectionView? = nil,
        cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) -> StoreArrayDatasource<Cell>
        where Cell.Model == Element {
            return StoreArrayDatasource<Cell>(backedBy: [self], for: collectionView, cellCommunicatesWith: interactionDelegate)
    }
}
