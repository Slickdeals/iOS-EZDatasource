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
