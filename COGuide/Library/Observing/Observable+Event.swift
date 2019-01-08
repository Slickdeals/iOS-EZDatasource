//
//  Observable+Event.swift
//  EZDatasources
//
//  Created by Dominic Rodriquez on 11/26/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation

/**
    This is the value you receive as an observer anytime an update is received from a store updating
 */
public struct Update<Element, Action> {
    
    // Value of the store prior to it updating
    public let oldValue: Element
    
    // New value of the store after the update
    public let value: Element
    
    // action that was taken
    public let triggedBy: Action
}

/**
    This is the value you receive as an observer anytime an update is received from a store updating
 */
public struct ObserverWrapper<Element, Action> {
    
    /**
     This is the closure property that gets invoked anytime the store is updated.
     When subscribing, this closure is what you will provide
     
     - parameters:
     - update: The only parameter is an instance of `Update<Element>`, which is what you receive after the store changes.
               This instance of `Update<Element>` will contain the oldValue, and the newValue of the store following the update.
     
     */
    public var closure: (Update<Element, Action>) -> Void
    
    /**
     This method is invoked for each observer subscribed to the store after the store updates.
     This method just executes the closure you supplied when you subscribed with the updated value.
     
     - parameters:
     - newValue: new value of the store following an update
     - oldValue: previous value of the store before updating
     */
    public func observableDidChange(from oldValue: Element, to newValue: Element, wasTriggeredBy action: Action) {
        closure(Update(oldValue: oldValue, value: newValue, triggedBy: action))
    }
}
