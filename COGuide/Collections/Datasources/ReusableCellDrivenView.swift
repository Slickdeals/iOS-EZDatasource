//
//  ReusableCellDrivenView.swift
//  COGuide
//
//  Created by Dominic Rodriquez on 1/8/19.
//  Copyright © 2019 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit

enum CellError: Error {
    case CellDequeueFailure(identifierUsed: String, targetedType: String)
    case CellRegistrationError(identifierUsed: String, targetedType: String)
    case WasNotCollectionViewCell
}

public protocol ReusableCellDrivenView: class {
    associatedtype CellType
    func sharedDequeueReusableCell<Cell: GuidedCell>(withReusableCellType cellType: Cell.Type, for indexPath: IndexPath) throws -> (asGuidedCell: Cell, asBaseCell: CellType)
}

public extension ReusableCellDrivenView {
    
    func sharedDequeueReusableCell<Cell: GuidedCell>(withReusableCellType cellType: Cell.Type, for indexPath: IndexPath) throws -> (asGuidedCell: Cell, asBaseCell: CellType) {
        
        var cell: Cell?
        
        switch self {
        case let collectionView as UICollectionView: cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? Cell
        case let tableView as UITableView: cell = tableView.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? Cell
        default: break
        }
        
        guard let validCell = cell, cell is CellType else {
            throw CellError.CellDequeueFailure(identifierUsed: cellType.reuseIdentifier, targetedType: String(describing: cellType))
        }
        return (validCell, validCell as! CellType)
    }
}

extension UITableView: ReusableCellDrivenView {
    public typealias CellType = UITableViewCell
}

extension UICollectionView: ReusableCellDrivenView {
    public typealias CellType = UICollectionViewCell
}

