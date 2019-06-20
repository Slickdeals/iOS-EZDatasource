//
//  Deal+Cells.swift
//  TryingEZDatasource
//
//  Created by Dominic Rodriquez on 1/3/19.
//  Copyright © 2019 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit
import COGuide

protocol FormattedContainerCell {
    static var containerType: Container { get }
    static var format: Format { get }
}

class FullBleedBlockCell: GuidedCollectionViewCell<Deal, ClickHandler>, FormattedContainerCell {
    static var containerType: Container { return .block }
    static var format: Format { return .fullBleedImage }
}
//class PillCell: UICollectionViewCell, FormattedContainerCell {
//    static var containerType: Container { return .pill }
//    static var format: Format { return .text }
//}
//class CellThree: UICollectionViewCell, FormattedContainerCell {
//    static var containerType: Container { return .block }
//    static var format: Format { return .imageTitleSubtitle }
//}

extension GuidedLayoutModel {
    
//    static func cell(for container: Container, with: Format) -> StoreArrayDatasource<Self> {
//
//    }
    
//    func makeDatasource<Cell: GuidedCell>(
//        for container: Container,
//        with format: Format,
//        cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) -> StoreArrayDatasource<Cell>?
//        where Cell.Model == Self {
//            
//            let formatToUse = container.supportedFormats.first(where: { $0 == format }) ?? defaultFormat
//            
//            switch (container, formatToUse) {
//            case (.block, .fullBleedImage):
//                let blockCellDS: StoreArrayDatasource<FullBleedBlockCell> = [self].makeDatasource(for: FullBleedBlockCell, for: nil, cellCommunicatesWith: interactionDelegate) as
//                return blockCellDS
//            default: return nil
//            }
//            //return StoreArrayDatasource<Cell>(backedBy: store, toDriveCollectionView: collectionView, cellCommunicatesWith: interactionDelegate)
//    }
    
//    public func makeDatasource<Cell: GuidedCell>(
//        for cellType: Cell.Type,
//        backedBy store: ArrayStore<Cell.Model> = Self.makeStore(),
//        for collectionView: UICollectionView? = nil,
//        cellCommunicatesWith interactionDelegate: Cell.Interactor? = nil) -> StoreArrayDatasource<Cell>
//        where Cell.Model == Self {
//            return StoreArrayDatasource<Cell>(backedBy: store, toDriveCollectionView: collectionView, cellCommunicatesWith: interactionDelegate)
//    }
}


struct ClickHandler {
    //    func handleClick(for cell: ) {
    //        print("")
    //    }
}

enum Container {
    case block
    case list
    case card
    case pill
    
    var supportedFormats: [Format] {
        switch self {
        case .block: return [.fullBleedImage, .imageTitle, .imageTitleSubtitle, .text]
        case .list:  return [.imageTitle, .imageTitleSubtitle]
        case .card:  return [.imageTitle, .imageTitleSubtitle]
        case .pill:  return [.imageTitle, .text]
        }
    }
}

enum Format {
    case fullBleedImage
    case imageTitle
    case imageTitleSubtitle
    case text
}

protocol HasImage {
    var image: UIImage { get set }
}

protocol ImageAndTitle: HasImage {
    var title: String { get set }
}

protocol ImageTitleSubtitle: ImageAndTitle {
    var subtitle: String { get set }
}

