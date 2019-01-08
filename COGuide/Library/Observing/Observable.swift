//
//  Observable.swift
//  EZDatasources
//
//  Created by Dominic Rodriquez on 10/1/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation

/**
  By adopting this protocol, You are agreeing to become an observable entity
 
  - You can subscribe to an Observable in order to receive updates when its value changes
  - You can unsubscribe from an Observable in order to no longer receive updates on change
  - You can receive updates via a perform method with an Action type you define
    that updates the value being obseved (if updating that value is applicable)
  - Observables internally manages its observers. A default implementation is provided for this

  What sort of situations would I want to use this for?
  - When you have something that needs to be monitored/watched.
    Generally because that value changing may result in side effects or triggers elsewhere
  - When you need to keep entities in sync with one another
  - When you need to process realtime data/messages that could happen at any point

  ##In order to conform to this protocol, you just have to tell me three things##
  1. The Element:
        What entity Type is being observed
  2. The Action:
        What entity Type can be sent to you (the entity conforming to Observable)
        in order be updated and subsequently notify all observers
  3. The Update method:
        This is the only required method to implement. The _ONLY_ thing you need to do
        here is to update the `value` property to whatever it should be set to after
        this method is called.

  ##Example:##
  ```
  // I have this manager that has messages. I now want to be able to publish updates to messages and for others to be notified when those changes happen
  public struct MessageManager: Observable {
 
      // I want to observe the contents of this
      public struct Contents {
          public var message: String?
      }
 
      // This is the action I want to update messages with
      public enum MessageUpdate {
          case newMessage(text: String)
          case clear
      }
 
      // This is the eneity type I want to observe
      public typealias Element = MessageManager.Contents?
 
      // This is the type I want to receive in order to update the value of the entity being observed
      public typealias Action = MessageManager.MessageUpdate
 
      public var value: Element
      public var observers: [String: ObserverWrapper<Element>] = [:]
 
      // this is the update method required.
      // All I have to do here is make sure I return the new value for the entity being obseved
      // anytime this method is called. It's called with one of the Actions that were defined
      // So I can inspect that action here, make whatever decisions I want to make to modify
      // the entity being observed, and then I return that entity
      // After this method is executed, the observers will be notified automatically
      public mutating func update(with action: Action, from oldValue: Element) -> Element {
 
          // I don't want to manually change the self.value property, that's managed for me
          // when I return the updated value from this method. So instead, make a copy
          // of the oldValue here and update it based on the value of the Action passed in
          // then return the new value
          var newValue = oldValue
          switch action {
          case .newMessage(let message): newValue?.message = message
          case .clear: newValue?.message = nil
          }
          return newValue
      }
  }
 ```
 */
public protocol Observable: class {
    
    // The type of entity that's being observed
    associatedtype Element
    
    // The type of Action that's used to update the entity being observed
    associatedtype Action
    
    // This is the closure that observers will provide when they subscribe
    // It's an empty closure that they supply that provides them with a single parameter
    // which is the updated value of the entity being observer along with its oldValue in case
    // they want to reference that
    typealias ObservableUpdateClosure = (Update<Element, Action>) -> Void
    
    // current value of the entity being observed
    var value: Element { get set }
    
    // all of the subscribed observers that will be notified when the entity being observed is updated
    // each observer is stored with a key that is generated and passed back to the subscriber.
    // That subscriber is then responsible for supplying that key again if they want to unsubscribe
    var observers: [String: ObserverWrapper<Element, Action>] { get set }
    
    /**
     This method takes the closure provided and holds onto it so that every time an update occurs,
     that closure is invoked with an update struct that has the oldValue and newValue
     
     - parameters:
     - closure: This is the closure executed everytime an update happens. This should contain whatever should happen every time an update happens
     
     - returns:
     uniquely generated string that you must have in order to unsubscribe. The generated key is used to store the closure you provide,
     so if you ever plan to unsubscribe, you'll want to hang onto it.
     
     */
    @discardableResult
    func startObserving(from closure: @escaping ObservableUpdateClosure) -> String

    /**
    Unsubscribes the closure assigned to the matching key, the key you supply should match the key given to you when you subscribed.
     
     - parameters:
     - key: This is the key that was generated to store the closure after you initially subscribed. It is passed back to the caller after subscribing,
            you must have this key in order to unsubscribe, otherwise it will hang onto the closure forever
     */
    func stopObserving(with key: String)
    
    /**
     Holds the previousValue then updates to the new value by internally calling the `update` method, then notifies all observers with the updated value and the previousValue.
     
     - THIS IS THE ONLY METHOD THAT SHOULD BE USED TO INTERACT WITH THE ENTITY BEING OBSERVED.
     
     - parameters:
     - action: the payload for this update, which will be forwarded to the update method in order to get the new value for the entity being observed
     
     */
    func perform(action: Action)
    
    /**
     This is the method that mutates the entity being observed
     
     - parameters:
     - action: This is the action that was supplied when the `perform` method was called, and should be used to determine how to update the entity being observed
     - oldValue: this is the value of the entity being observed "right now". It hasn't been updated yet. That's your job- right here.
                 Make a copy of this locally, mutate it to be whatever it should be given the action, then return that value
     
     - returns:
        The new value of the entity being observed given the provided action.
     
     */
    func update(with action: Action, from oldValue: Element) -> Element
}

// MARK: Default Implementation
public extension Observable {
    
    @discardableResult
    public func startObserving(from closure: @escaping ObservableUpdateClosure) -> String {
        // generate a new unique string to store the closure with
        let observerKey = UUID().uuidString
        
        // set the value of that key to a wrapper for the closure
        observers[observerKey] = ObserverWrapper<Element, Action>(closure: closure)
        
        // return the key to the observer so that they can unsubscribe when needed
        return observerKey
    }
    
    public func stopObserving(with key: String) {
        // remove the observer stored under the value of the key provided
        // this key should match the key supplied when initially subscribing
        observers.removeValue(forKey: key)
    }
    
    public func perform(action: Action) {
        
        // assign the value to be whatever the updated value is, which is supplied by the update function
        let valueBeforeUpdate = value
        value = update(with: action, from: valueBeforeUpdate)
        
        print("observers: perform - \(observers.count)")
        
        // now that we have the new value and the old value, notify each observer
        observers.values.forEach { observer in
            observer.observableDidChange(from: valueBeforeUpdate, to: value, wasTriggeredBy: action)
        }
    }
}
