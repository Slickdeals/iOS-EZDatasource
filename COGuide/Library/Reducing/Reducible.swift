//
//  Reducible.swift
//  EZDatasources
//
//  Created by Dominic Rodriquez on 10/1/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation

/**
    By adopting this protocol, you effectively enable yourself to become a data reducer.
 
     What the fuck is a reducer you ask? What a great fucking question, let me serenade you
     for the next 86 minutes with an eloquent description of that.
 
     ...kidding (for now)
 
     A reducer is just something that provides instructions for combining things.
 
     In this case, you're combining your current state along with the information contained in
     an action into a new version of yourself.
 
    As a simplified analogy, you could break down everything you do as a person and describe it in the same way
    The type we would assign to "Action" would be an enum that lists a case for all verbs we could do
    each verb may or may not require something to do it, such as eating something
 
    ```
     enum PersonAction {
        case eat(food: Food)
     }
    ```
 
    If I had an instance of a person created, then by combining the current state of that person with the `PersonAction.eat(food: DeliciousGoong)`
    Then the output would be an instance of a person that's exactly the same in every way except it's `isFull` status is now `true` instead of `false`
 
 
    ##In order to conform to this protocol, you just have to tell me two things##
    1. What type of object do you need in order to make any decision
       that would result in you changing (mutating) in some way
    2. Now fill in wtf happens when you get one of those actions by supplying your reduce function
       I'm going to give you one of those actions, and a copy of yourself. Do whatever you want
       to the copy of yourself based on what the action is, and then send it back to me.
 
    Now that you've done those things, I could define something like a store as a reducer
 
    ##Example:##
    ```
    struct CommentStore {
        var comments: [Comment]
        var featuredComments: [FeaturedComment]
 
        var selectedComment: Comment?
        var newPostInProgress: Comment?
        var editedComment: Comment?
 
        var commentOwnerId: Int?
 
        var hasStaleData: Bool
 
        init(comments: [Comment] = [],
             featuredComments: [FeaturedComment] = [],
             selectedComment: Comment? = nil,
             editedComment: Comment? = nil,
             newPostInProgress: Comment? = nil,
             commentOwnerId: Int? = nil,
             hasStaleData: Bool = false) {
 
           self.comments = comments
           self.featuredComments = featuredComments
           self.selectedComment = selectedComment
           self.editedComment = editedComment
           self.newPostInProgress = newPostInProgress
           self.commentOwnerId = commentOwnerId
           self.shouldReloadComments = shouldReloadComments
        }
    }
    ```
    In this example, I have a comment store. Instead of adding methods to make decisions and change data,
    let's adopt the Reducible protocol to isolate any mutations into a safe and singular location
 
    ```
 extension CommentStore: Reducible {
 
    public enum CommentAction {
        case reset
        case markAsStale
        case select(id: Int)
        case edit(id: Int, myUserId: Int, newText: String)
        case updateComments(comments: [Comment])
        case updateFeaturedComments(comments: [FeaturedComment])
        case assignOwner(ownerId: Int)
    }
 
    public mutating func reduced(by action: CommentAction, from oldValue: CommentStore) -> CommentStore {
       var newValue = oldValue
       switch action {
           case .reset:
                newValue = CommentStore(hasStaleData: true)
           case .markAsStale:
               newValue.hasStaleData = true
           case .select(let id):
               newValue.selectedComment = newValue.comments.first(where: { $0.id == id })
            case edit(id: Int, myUserId: Int, newText: String)
               newValue.comments = newValue.comments.map {
                  guard $0.id == id && $0.ownerId == myUserId else { return $0 }
                  var commentToEdit = $0
                  commentToEdit.body = newText
                  newValue.editedComment = commentToEdit
                  newValue.hasStaleData = true
                  return commentToEdit
               }
           case .updateComments(let comments):
               newValue.comments = comments
           case .updateFeaturedComments(let featuredComments):
               newValue.featuredComments = featuredComments
           case .assignOwner(let ownerId):
               newValue.ownerId = ownerId
               newValue.hasStaleData = true
       }
       return newValue
    }
 }
    ```
*/
public protocol Reducible {
    
    /**
     Think of the Action as the "API definition" for this object, where each enum case specifies the
     payload required in order to take that action
    */
    associatedtype Action
    
    /**
     the reduction function provides the instructions/rules that determine what happens when an action is called.
     This function should _never_ reach outside of its own scope, and by that I mean
     
     "Touch nothing but the lamp" (except in this version of Alladin, the lamp is your list of function arguments)
     
     The idea here is that instead of exposing methods and properties that enable others to mutate you, instead you
     supply a singular method for changing absolutely anything about yourself.
     
        - That method receives the current value/instance of "you" ("you" being whoever adopts this protocol)
        - Instead of your actual values, create a local copy of the "oldValue" parameter. This is what you'll mutate
        - switch across your action and whatever data it contains, make the appropriate changes to the local copy based on the data
        - return the modified value. The instance of the object that adopted this protocol now _becomes_ the new value.
     
     - parameters:
        - action: the action is basically the payload you're getting that you should use to determine how to transform yourself
        - oldValue: this is the value of yourself just before this function was called
     
     - returns:
     The new version of yourself after applying whatever changes are appropriate for the provided action
     
     */
    mutating func reduced(by action: Action, from oldValue: Self) -> Self
}
