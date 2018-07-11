//
//  CompositeDatasource.swift
//  SlickdealsCore

import Foundation
import UIKit

public protocol CompositeDataSourceDelegate {
    func configureCell<SourceType: UICollectionViewDataSource & UICollectionViewDelegate>(cell: UICollectionViewCell, itemSource: SourceType, at indexPath: IndexPath) -> UICollectionViewCell
}

open class CompositeDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    public typealias SourceType = UICollectionViewDataSource & UICollectionViewDelegate
    
    public var sources: [SourceType]
    public var delegate: CompositeDataSourceDelegate?
    
    public init(withSources sources: [SourceType]) {
        self.sources = sources
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sources.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sources[section].collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemSource = sources[indexPath.section]
        let cell = itemSource.collectionView(collectionView, cellForItemAt: indexPath)
        
        return delegate?.configureCell(cell: cell, itemSource: itemSource, at: indexPath) ?? cell
    }
}


