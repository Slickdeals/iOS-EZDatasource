//
//  ConfigurableCell.swift
//  GenericDataSource
//
//  Created by Andrea Prearo on 4/20/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import UIKit

public protocol EZCell: EZView, ReusableCell {}

public protocol EZCellWrappingView: EZCell where View: EZView {
    associatedtype View where View: UIView
    var wrappedView: View? { get set }
}

public extension EZCell where Self: UICollectionViewCell {
    
    public static func makeDatasource(for collectionView: UICollectionView, with items: [Model] = [], cellDelegate: Delegate? = nil) -> StoreArrayDatasource<Self> {
        return StoreArrayDatasource<Self>(collectionView: collectionView, array: items, cellDelegate: cellDelegate)
    }
    
    public static func makeDatasource(for collectionView: UICollectionView, with store: ArrayStore<Model>, cellDelegate: Delegate? = nil) -> StoreArrayDatasource<Self> {
        return StoreArrayDatasource<Self>(collectionView: collectionView, store: store, cellDelegate: cellDelegate)
    }
    
}

public protocol EZFactory {}

public extension EZFactory {
    
    public static func makeStore(with items: [Self] = []) -> ArrayStore<Self> {
        return ArrayStore<Self>(items: items)
    }
    
    public static func makeDatasource<CellType: EZCell>(for collectionView: UICollectionView, with store: ArrayStore<CellType.Model> = Self.makeStore(), cellDelegate: CellType.Delegate? = nil) -> StoreArrayDatasource<CellType>
        where CellType.Model == Self {
        return StoreArrayDatasource<CellType>(collectionView: collectionView, store: store, cellDelegate: cellDelegate)
    }
    
    public static func makeDatasource<CellType: EZCell>(for collectionView: UICollectionView, with items: [CellType.Model] = [], cellDelegate: CellType.Delegate? = nil) -> StoreArrayDatasource<CellType>
        where CellType.Model == Self {
        return StoreArrayDatasource<CellType>(collectionView: collectionView, array: items, cellDelegate: cellDelegate)
    }
    
}
