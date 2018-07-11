//
//  ConfigurableCell+DefaultConfiguration.swift
//  SlickdealsCore
//
//  Created by Dominic Rodriquez on 6/26/18.
//  Copyright © 2018 Slickdeals, LLC. All rights reserved.
//

import UIKit

public extension EZCellWrappingView where Self: UICollectionViewCell, View: EZView, Model == View.Model, Delegate == View.Delegate {
    
    public func setup(for model: Model?, at indexPath: IndexPath?, with actionDelegate: Delegate?) {
        defer { updateStyles() }
        guard wrappedView == nil else {
            wrappedView?.setup(for: model, at: indexPath, with: actionDelegate)
            return
        }
        let view: View = View.init()
        setup(byWrapping: view, for: model, at: indexPath, with: actionDelegate)
    }
    
    public func setup<View: UIView>(byWrapping view: View, for model: Model?, at indexPath: IndexPath?, with actionDelegate: Delegate?) where View: EZView, View.Model == Model, View.Delegate == Delegate {
        view.model = model
        view.delegate = actionDelegate
        attachCell(to: view)
        view.setup(for: model, at: indexPath, with: actionDelegate)
    }
    
//    public func configure(_ actionDelegate: Delegate?, model: Model, at indexPath: IndexPath?) {
//        defer { updateStyles() }
//        guard wrappedView == nil else {
//            wrappedView?.configure(actionDelegate: actionDelegate, modelItem: modelItem, at: indexPath)
//            return
//        }
//        let view: View = View.init()
//
//    }
    
    
    func attachCell(to view: UIView) {
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    public func updateStyles() {
        contentView.backgroundColor = UIColor.clear
        contentView.layer.borderColor = UIColor.clear.cgColor
        layer.borderColor = UIColor.clear.cgColor
        backgroundColor = UIColor.clear
        contentView.clipsToBounds = false
        clipsToBounds = false
    }
//
//    func configure(at indexPath: IndexPath?) {
//        defer { updateStyles() }
//        guard wrappedView == nil else {
//            wrappedView?.configure()
//            return
//        }
//        let view: View = View.init()
//        configure(byFillingCellWith: view)
//    }
//
//    public func configure<View: UIView>(byFillingCellWith view: View) where View: EZView {
//        attachCell(to: view)
//    }

}

public extension EZCellWrappingView where Self: EZView {
    public var model: View.Model? {
        get {
            return wrappedView?.model
        }
        set {
            wrappedView?.model = newValue
        }
    }
    public var delegate: View.Delegate? {
        get {
            return wrappedView?.delegate
        }
        set {
            wrappedView?.delegate = newValue
        }
    }
}

//extension EZCellWrappingView where Self: EZCellWrappingActionableView {
//    var delegate: View.Delegate? {
//        get {
//            return wrappedView?.delegate
//        }
//        set {
//            wrappedView?.delegate = newValue
//        }
//    }
//}
//
//extension EZCellWrappingView where Self: EZCellWrappingActionableModelDrivenView {
//    var modelItem: View.Model? {
//        get {
//            return wrappedView?.modelItem
//        }
//        set {
//            wrappedView?.modelItem = newValue
//        }
//    }
//
//    var delegate: View.Delegate? {
//        get {
//            return wrappedView?.delegate
//        }
//        set {
//            wrappedView?.delegate = newValue
//        }
//    }
//}
//
//public extension EZCellWrappingModelDrivenView where Self: UICollectionViewCell, View.Model == Model {
//
//    func configure(_ item: Model, at indexPath: IndexPath?) {
//        defer { updateStyles() }
//        guard wrappedView == nil else {
//            wrappedView?.configure(item, at: indexPath)
//            return
//        }
//        let view: View = View.init()
//        configure(item, byFillingCellWith: view, at: indexPath)
//    }
//
//    public func configure<View: UIView>(_ item: Model, byFillingCellWith view: View, at indexPath: IndexPath?) where View: EZModelDrivenView, View.Model == Model {
//        view.modelItem = item
//        view.configure(item, at: indexPath)
//        attachCell(to: view)
//    }
//}
//
//public extension EZCellWrappingActionableView where Self: UICollectionViewCell, View: EZActionableView, View.Delegate == Delegate {
//
//    func configure(_ actionDelegate: Delegate?, at indexPath: IndexPath?) {
//        defer { updateStyles() }
//        guard wrappedView == nil else {
//            wrappedView?.configure(actionDelegate: actionDelegate, at: indexPath)
//            return
//        }
//        let view: View = View.init()
//        configure(actionDelegate: actionDelegate, byFillingCellWith: view, at: indexPath)
//    }
//
//    public func configure<View: UIView>(actionDelegate: Delegate?, byFillingCellWith view: View, at indexPath: IndexPath?) where View: EZActionableView, View.Delegate == Delegate {
//        view.delegate = actionDelegate
//        view.configure(actionDelegate: actionDelegate, at: indexPath)
//        attachCell(to: view)
//    }
//}

//public extension EZCellWrappingActionableModelDrivenView where Self: UICollectionViewCell, View.Model == Model, View.Delegate == Delegate, View: EZActionableModelDrivenView {
//
//    public func configure(_ actionDelegate: Delegate?, modelItem: Model, at indexPath: IndexPath?) {
//        defer { updateStyles() }
//        guard wrappedView == nil else {
//            wrappedView?.configure(actionDelegate: actionDelegate, modelItem: modelItem, at: indexPath)
//            return
//        }
//        let view: View = View.init()
//        configure(actionDelegate: actionDelegate, modelItem: modelItem, byFillingCellWith: view, at: indexPath)
//    }
//
//    public func configure<View: UIView>(actionDelegate: Delegate?, modelItem: Model, byFillingCellWith view: View, at indexPath: IndexPath?) where View: EZActionableModelDrivenView, View.Model == Model, View.Delegate == Delegate {
//        view.modelItem = modelItem
//        view.delegate = actionDelegate
//        view.configure(actionDelegate: actionDelegate, modelItem: modelItem, at: indexPath)
//        attachCell(to: view)
//    }
//}
