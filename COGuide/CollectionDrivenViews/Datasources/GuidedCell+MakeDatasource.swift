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
    
    public static func makeDatasource(backedBy items: [Model] = [],
                                      for collectionView: UICollectionView,
                                      cellCommunicatesWith interactionDelegate: Interactor? = nil) -> StoreArrayDatasource<Self> {
        return StoreArrayDatasource<Self>(backedBy: [items], for: collectionView, cellCommunicatesWith: interactionDelegate)
    }
    
    public static func makeDatasource(backedBy store: ArrayStore<Model>,
                                      for collectionView: UICollectionView,
                                      cellCommunicatesWith interactionDelegate: Interactor? = nil) -> StoreArrayDatasource<Self> {
        return StoreArrayDatasource<Self>(backedBy: store, for: collectionView, cellCommunicatesWith: interactionDelegate)
    }
}
