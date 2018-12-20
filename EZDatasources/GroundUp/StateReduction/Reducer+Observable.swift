//
//  Reducer+Observable.swift
//  EZDatasources
//
//  Created by Dominic Rodriquez on 11/27/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation

public protocol ObservableReducer: Observable where Element: Reducible {}

public extension Observable where Element: Reducible, Self.Action == Element.Action  {
    
    typealias ActionType = Element.Action
    
    // For reducers, the updated value will always be its reduce method.
    public func update(with action: Action, from oldValue: Element) -> Element {
        var newValue = oldValue
        return newValue.reduced(by: action, from: oldValue)
    }
}


