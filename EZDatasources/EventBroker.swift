//
//  EventBroker.swift
//  EZDatasources
//
//  Created by Dominic Rodriquez on 7/12/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation

public typealias GeneralEventData = [AnyHashable : Any]
public typealias GeneralSubscriberCollection = [String : [ExplicitSubscriberAction<GeneralEventData>]]
public typealias GeneralEventHandler = (String, GeneralEventData) -> Void

public protocol EventSubscriber {
    associatedtype EventData
    associatedtype EventHandler = (String, EventData) -> Void
    var subscriber: AnyHashable { get set }
    var handler: EventHandler { get set }
}

public struct ExplicitSubscriberAction<EventData>: EventSubscriber {
    public typealias EventHandler = (String, EventData) -> Void
    public var subscriber: AnyHashable
    public var handler: EventHandler
}

public protocol ExplicitEventBroker {
    
    associatedtype EventData
    typealias Subscriber = ExplicitSubscriberAction<EventData>

    var subscribedEvents: [String: [Subscriber]] { get set }
    
    func publish(event: String, with eventInfo: [AnyHashable : Any])
    
    mutating func subscribe(to event: String, subscriber: AnyHashable, with handler: @escaping Subscriber.EventHandler)
    
    mutating func unsubscribe(to event: String, subscriber: AnyHashable)
}

public extension ExplicitEventBroker {

    public func publish(event: String, with eventInfo: EventData) {
        guard let subscriberActions = subscribedEvents[event] else { return }
        for subscriberAction in subscriberActions {
            subscriberAction.handler(event, eventInfo)
        }
    }

    public mutating func subscribe(to event: String, subscriber: AnyHashable, with handler: @escaping Subscriber.EventHandler) {
        let subscriberAction = ExplicitSubscriberAction(subscriber: subscriber, handler: handler)
        var subscriberActions: [Subscriber]
        if let _subscriberActions: [ExplicitSubscriberAction] = subscribedEvents[event]  {
            subscriberActions = _subscriberActions
        } else {
            subscriberActions = [subscriberAction]
        }
        subscribedEvents[event] = subscriberActions
    }

    public mutating func unsubscribe(to event: String, subscriber: AnyHashable) {
        guard var subscriberActions = subscribedEvents[event] else { return }
        var index = 0
        for subscriberAction in subscriberActions {
            if subscriberAction.subscriber == subscriber {
                break
            }
            index = index + 1
        }
        subscriberActions.remove(at: index)
        subscribedEvents[event] = subscriberActions
    }
}

public protocol EventBroker: ExplicitEventBroker where EventData == GeneralEventData {}


public struct Model: EventBroker {
    public var subscribedEvents: GeneralSubscriberCollection
}

public struct Other {
    
    var subscriberID = UUID().uuidString
    
    let handler: GeneralEventHandler = {
        (name, data) in
            print(name)
            print(data)
    }
    
    lazy var test: ExplicitSubscriberAction<GeneralEventData> = {
        let subscriberAction = ExplicitSubscriberAction<GeneralEventData>(subscriber: subscriberID, handler: handler)
        return subscriberAction
    }()
}
