import Foundation
import UIKit

public protocol EZEmptyActionDelegate {
    var oops: Bool { get  }
}
public protocol EZEmptyModel {
    var oops: Bool { get }
}
public extension EZEmptyActionDelegate {
    public var oops: Bool { return false}
}
public extension EZEmptyModel {
    public var oops: Bool { return false }
}

open class EZCollectionViewCell: UICollectionViewCell, EZCell {
    public typealias Model = EZEmptyModel
    public typealias Delegate = EZEmptyActionDelegate
    open var model: Model?
    open var delegate: Delegate?
    
    open override func prepareForReuse() {
        model = nil
        delegate = nil
    }
    
    open func setup(for model: Model?, at indexPath: IndexPath?, with actionDelegate: Delegate?) {
        self.model = model
        self.delegate = actionDelegate
        self.setup(at: indexPath)
    }
    
    open func setup(at indexPath: IndexPath?) {}
}

open class EZCollectionViewCellWrappingView<ViewType: UIView>: EZCollectionViewCell, EZCellWrappingView where ViewType: EZView {
    public typealias View = ViewType
    public var wrappedView: View?
}
