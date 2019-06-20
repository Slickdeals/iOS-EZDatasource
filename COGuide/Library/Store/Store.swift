//
//  Store.swift
//  EZDatasources
//
//  Created by Dominic Rodriquez on 11/26/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation

/**
 
 A store represents a container for data that faciliates the following
 
 - Making changes through actions:
    You are required to define the `Action` type used by the store for actions.
    To update the store, you call the `.publish` method and provide an instance of the action
 
 - Single point of mutation:
    You are required to supply the method that reduces the store from one state to another.
    You're given action that was taken, and the previous value of the store.
    Return whatever the new state of the store is like given that information.
 
 - Observing any changes:
    Anytime something in a store changes, it notifies all observers with its old value and new value


 ##Example:##
 ```
 public class User {}
 public class Deal {}
 
 public struct DealStore {
 
    var deals: [Deal]
    var currentlySelectedDeal: Deal?
 
    init(deals: [Deal] = [], currentlySelectedDeal: Deal? = nil) {
        self.deals = deals
        self.currentlySelectedDeal = currentlySelectedDeal
    }
 }
 
 extension DealState: Reducible {
 
    public typealias Action = DealAction
 
    public enum DealAction {
 
        // if we're going to refresh the deals, we'll need to supply the new deals to refresh it with
        case refresh(deals: [Deal])
 
        // if we're going to add a new deal, then we'll need to supply whatever deal we're adding
        case add(deal: Deal)
 
        // to delete a deal, we just need a way to identify which deal to delete
        case delete(id: Int)
 
        // to select a deal, we just need a way to identify which deal to select
        case select(id: Int)
    }
 
     public mutating func reduced(by action: Action, from oldValue: DealState) -> DealState {
 
         // first we need a local mutable copy of the store
         var updatedStore = oldValue
 
         // Now we will switch across the type of action that we defined to figure out what we need to do to the store
         switch action {
 
         case .refresh(let deals):
            // Since we're refreshing the store's deals, we'll just replace the entire array of deals with new array of deals
            updatedStore.deals = deals
 
            // Since we replaced all the deals, it's possible that we no longer have the deal that was selected
            // Let's update the value for the currently selected deal as well to point the matching deal, otherwise set to nil
            guard let previouslySelectedStore = updatedStore.currentlySelectedDeal,
                  let matchingStoreToSelect = updatedStore.deals.first(where: { $0.id == previouslySelectedStore.id })
            else {
                // if no matching deal was found in the new list, set it to nil
                updatedStore.currentlySelectedDeal = nil
            }
 
            // if we found a deal that matches the previously selected deal, then we can update the currentlySelectedDeal to point to that deal
            updatedStore.currentlySelectedDeal = matchingStoreToSelect
 
         case .add(let deal):
            // We just need to add a deal to the end of the deal list here.
            updatedStore.deals.append(deal)
 
         case .delete(let dealId):
            // update the deal list to remove the deal from the list if present
            updatedStore.deals = updatedStore.deals.filter { return $0.id != dealId }
 
            // we also want to update the currentlySelectedDeal if the deal we removed was that deal
            guard updatedStore.currentlySelectedDeal?.id == dealId else { return }
            updatedStore.currentlySelectedDeal = nil
 
         case .select(let id):
            // we want to set which deal is currently selected, so we'll attempt to assign it to the deal matching the id provided
            updatedStore.currentlySelectedDeal = updatedStore.deals.first(where: { $0.id == id })
        }
 
        // Now that we've updated the store to reflect the new values we want, we return the new value for the store.
        // The new value will replace the old one, and observers will be notified and passed the updated value.
        return updatedStore
     }
 
 }
 ```
 */
public class Store<Model: Reducible>: ObservableReducer {
    
    /**
        You decide what type of action is appropriate for updating your store.
        Enums are recommended, as they provide a clean interface for presenting
        all of the available options in an API like fashion.
     
        The action will need to carry all of the data necessary to update the store.
        For instance, if you wanted an action to update your store with a new collection of model items,
        the action would need to carry those model items as its payload in order to update the store with them.
     */
    public typealias Action = Model.Action
    
    /**
        This is the current value of the store, which is an instance of the Model the entity this store manages.
        Your entity should have all of the state and propeties you want to manage for your store.
        - You will never modify this value
     */
    public var value: Model
    
    /**
        This is the collection of observers currently watching for changes
     */
    public var observers: [String: ObserverWrapper<Model, Action>] = [:]
    
    /**
     Initializes the store of the specified type with the initial value you provide
     
     - Until the store is updated, `value` and `previousValue` will be equal
     
     - parameters:
     - initialValue: this is the instance of your Model Type that the store will initially be set to
     
     */
    public init(initialValue: Model) {
        value = initialValue
    }
}
