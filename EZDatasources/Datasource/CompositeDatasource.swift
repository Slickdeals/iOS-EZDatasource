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
        super.init()
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (0..<sources.count).reduce(0) { totalSections, datasourceIndex in
            return sources[datasourceIndex].numberOfSections!(in: collectionView) + totalSections
            //return datasource.numberOfSections!(in: collectionView) + totalSections
        }

    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let datasourceSection = section - sectionOffset(for: section, in: collectionView)
        let itemsInSection = sources[section].collectionView(collectionView, numberOfItemsInSection: datasourceSection)
        return itemsInSection
//        return (0..<sources[section].numberOfSections!(in: collectionView)).reduce(0) { totalSections, section in
//            return sources[section].collectionView(collectionView, numberOfItemsInSection: section) + totalSections
//        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // whatever section it gives me has to be the actual section for that collection
        let datasourceSection = indexPath.section - sectionOffset(for: indexPath.section, in: collectionView)
        let datasource = sources[indexPath.section]
        let datasourceItemIndex = IndexPath(item: indexPath.item, section: datasourceSection)
        let cell = datasource.collectionView(collectionView, cellForItemAt: datasourceItemIndex)
        return cell
    }
    
    func sectionOffset(for section: Int, in collectionView: UICollectionView) -> Int {
        return (0..<section).reduce(0) { sections, previousSection in
            return sources[previousSection].numberOfSections!(in: collectionView) + sections
        }
    }
}


