//
//  GenericEventBroker.swift
//  EZDatasources
//
//  Created by Dominic Rodriquez on 7/13/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation

public protocol EventSubscriber {
    var subscriber: AnyHashable { get set }
}

public struct ExplicitSubscriberAction<EventData>: Equatable, EventSubscriber {
    public typealias EventHandler = (String, EventData) -> Void
    public var subscriber: AnyHashable
    public var handler: EventHandler
    
    public static func ==(lhs: ExplicitSubscriberAction<EventData>, rhs: ExplicitSubscriberAction<EventData>) -> Bool {
        return lhs.subscriber == rhs.subscriber
    }
}

public struct BasicSubscriberAction: Equatable, EventSubscriber {
    public typealias EventHandler = (String) -> Void
    public var subscriber: AnyHashable
    public var handler: EventHandler
    
    public static func ==(lhs: BasicSubscriberAction, rhs: BasicSubscriberAction) -> Bool {
        return lhs.subscriber == rhs.subscriber
    }
}

public protocol ExplicitEventBroker {
    
    associatedtype EventData
    associatedtype EventDataCollection: Sequence where EventDataCollection.Element == EventData
    typealias Subscriber = ExplicitSubscriberAction<EventData>
    typealias CollectionSubscriber = ExplicitSubscriberAction<EventDataCollection>
    
    var eventsAvailable: [String] { get set }
    
    var basicSubscribedEvents: [String: [BasicSubscriberAction]] { get set }
    var subscribedEvents: [String: [Subscriber]] { get set }
    var subscribedCollectionEvents: [String: [CollectionSubscriber]] { get set }
    
    func publish(event: String)
    
    func publish(event: String, with eventInfo: EventData)
    
    func publish(event: String, with eventInfo: EventDataCollection)
    
    mutating func subscribe(to event: String, subscriber: AnyHashable, with handler: @escaping BasicSubscriberAction.EventHandler)
    
    mutating func subscribe(to event: String, subscriber: AnyHashable, with handler: @escaping Subscriber.EventHandler)
    
    mutating func subscribe(to event: String, subscriber: AnyHashable, with handler: @escaping CollectionSubscriber.EventHandler)
    
    mutating func unsubscribe(to event: String, subscriber: AnyHashable)
}

public extension ExplicitEventBroker {
    
    public func publish(event: String) {
        guard let subscriberActions = basicSubscribedEvents[event] else { return }
        subscriberActions.forEach { subscriber in subscriber.handler(event) }
    }
    
    public func publish(event: String, with eventCollectionData: EventDataCollection) {
        guard let subscriberActions = subscribedCollectionEvents[event] else { return }
        subscriberActions.forEach { subscriber in subscriber.handler(event, eventCollectionData) }
    }
    
    public func publish(event: String, with eventInfo: EventData) {
        guard let subscriberActions = subscribedEvents[event] else { return }
        subscriberActions.forEach { subscriber in subscriber.handler(event, eventInfo) }
    }
    
    public mutating func subscribe(to event: String, subscriber: AnyHashable, with handler: @escaping Subscriber.EventHandler) {
        let subscriberAction = ExplicitSubscriberAction(subscriber: subscriber, handler: handler)
        guard let currentSubscribedEvents = subscribedEvents[event] else { return subscribedEvents[event] = [subscriberAction] }
        if let currentIndex = currentSubscribedEvents.index(of: subscriberAction) {
            subscribedEvents[event]?[currentIndex] = subscriberAction
        }
        else {
            subscribedEvents[event] = currentSubscribedEvents + [subscriberAction]
        }
    }
    
    public mutating func subscribe(to event: String, subscriber: AnyHashable, with handler: @escaping BasicSubscriberAction.EventHandler) {
        let subscriberAction = BasicSubscriberAction(subscriber: subscriber, handler: handler)
        guard let currentSubscribedEvents = basicSubscribedEvents[event] else { return basicSubscribedEvents[event] = [subscriberAction] }
        if let currentIndex = currentSubscribedEvents.index(of: subscriberAction) {
            basicSubscribedEvents[event]?[currentIndex] = subscriberAction
        }
        else {
            basicSubscribedEvents[event] = currentSubscribedEvents + [subscriberAction]
        }
    }
    
    public mutating func subscribe(to event: String, subscriber: AnyHashable, with handler: @escaping CollectionSubscriber.EventHandler) {
        let subscriberAction = ExplicitSubscriberAction(subscriber: subscriber, handler: handler)
        guard let currentSubscribedEvents = subscribedCollectionEvents[event] else { return subscribedCollectionEvents[event] = [subscriberAction] }
        if let currentIndex = currentSubscribedEvents.index(of: subscriberAction) {
            subscribedCollectionEvents[event]?[currentIndex] = subscriberAction
        }
        else {
            subscribedCollectionEvents[event] = currentSubscribedEvents + [subscriberAction]
        }
    }
    
    
    public mutating func unsubscribe(to event: String, subscriber: AnyHashable) {
        subscribedEvents[event] = subscribedEvents[event]?.filter { $0.subscriber == subscriber }
        basicSubscribedEvents[event] = basicSubscribedEvents[event]?.filter { $0.subscriber == subscriber }
        subscribedCollectionEvents[event] = subscribedCollectionEvents[event]?.filter { $0.subscriber == subscriber }
    }
}

