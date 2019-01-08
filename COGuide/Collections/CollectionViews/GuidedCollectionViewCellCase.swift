//
//  GuidedCollectionViewCellCase.swift
//  COGuide
//
//  Created by Dominic Rodriquez on 12/20/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit

open class GuidedCollectionViewCellCase<ViewType: UIView>: GuidedEmptyCollectionViewCell, GuidedCellCase where ViewType: GuidedComponent {
    public typealias View = ViewType
    public var viewConstrainedToCell: View?
}

public extension GuidedCellCase where Self: UICollectionViewCell, View: GuidedComponent, Model == View.Model, Interactor == View.Interactor {
    
    public func configure(with model: Model?, at position: IndexPath?, communicatesWith interactionDelegate: Interactor?) {
        defer { updateStyles() }
        guard viewConstrainedToCell == nil else {
            viewConstrainedToCell?.configure(with: model, at: position, communicatesWith: interactionDelegate)
            return
        }
        let view: View = View.init()
        configure(byWrapping: view, with: model, at: position, communicatesWith: interactionDelegate)
    }
    
    public func configure<View: UIView>(byWrapping view: View, with model: Model?, at position: IndexPath?, communicatesWith interactionDelegate: Interactor?) where View: GuidedComponent, View.Model == Model, View.Interactor == Interactor {
        view.model = model
        view.interactor = interactionDelegate
        attachCell(to: view)
        view.configure(with: model, at: position, communicatesWith: interactionDelegate)
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

public extension GuidedCellCase where Self: GuidedComponent {
    public var model: View.Model? {
        get {
            return viewConstrainedToCell?.model
        }
        set {
            viewConstrainedToCell?.model = newValue
        }
    }
    public var delegate: View.Interactor? {
        get {
            return viewConstrainedToCell?.interactor
        }
        set {
            viewConstrainedToCell?.interactor = newValue
        }
    }
}
