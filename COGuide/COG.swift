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
    
    public static func makeDatasource<CellType: GuidedCell>(
        backedBy store: ArrayStore<CellType.Model> = Self.makeStore(),
        for collectionView: UICollectionView,
        cellCommunicatesWith interactionDelegate: CellType.Interactor? = nil) -> StoreArrayDatasource<CellType>
        where CellType.Model == Self {
            return StoreArrayDatasource<CellType>(backedBy: store, for: collectionView, cellCommunicatesWith: interactionDelegate)
    }
    
    public static func makeDatasource<CellType: GuidedCell>(
        backedBy items: [CellType.Model] = [],
        for collectionView: UICollectionView,
        cellCommunicatesWith interactionDelegate: CellType.Interactor? = nil) -> StoreArrayDatasource<CellType>
        where CellType.Model == Self {
            return StoreArrayDatasource<CellType>(backedBy: [items], for: collectionView, cellCommunicatesWith: interactionDelegate)
    }
    
}
