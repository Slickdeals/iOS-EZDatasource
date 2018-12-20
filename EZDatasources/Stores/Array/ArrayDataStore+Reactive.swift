//
//  ArrayDataStore+Reactive.swift
//  EZDatasources
//
//  Created by Dominic Rodriquez on 7/17/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit

//public enum StoreEvent: String {
//    case didCompleteLoading
//    case didBeginLoading
//    case didFailLoading
//    case didLoadItem
//    case didLoadItemCollection
//    
//    static var allEvents: [String] {
//        let events: [StoreEvent] =  [
//            .didCompleteLoading,
//            .didBeginLoading,
//            .didFailLoading,
//            .didLoadItem,
//            .didLoadItemCollection
//        ]
//        return events.map({ $0.rawValue })
//    }
//}

//open class ObservableArrayStore<Model>: ArrayDataStore<Model>, ObservableReducer {
//
//    public typealias Action = Model.Action
//
//    public var previousValue: Model
//
//    public var value: Model
//
//    public var observers: [String: ObserverWrapper<Model>] = [:]
//
//    public init(initialValue: Model) {
//        value = initialValue
//        previousValue = initialValue
//    }
//}

//open class ReactiveArrayDataStore<Model>: ArrayDataStore<Model>, ExplicitEventBroker {
//
//    public typealias EventData = Model
//    public typealias EventDataCollection = ModelCollection
//    public typealias EventHandler = (EventData) -> Void
//    public typealias Subscriber = ExplicitSubscriberAction<EventData>
//    public typealias CollectionSubscriber = ExplicitSubscriberAction<ModelCollection>
//
//    public typealias FetchAllSuccess = (ModelCollection) -> Void
//    public typealias FetchOneSuccess = (EventData, IndexPath) -> Void
//    public typealias FetchFailure = (StoreError) -> Void
//
//
//    public var eventsAvailable: [String] = StoreEvent.allEvents
//
//    public var subscriptions: [String : EventHandler] = [:]
//    public var basicSubscribedEvents: [String : [BasicSubscriberAction]] = [:]
//    public var subscribedEvents: [String : [Subscriber]] = [:]
//    public var subscribedCollectionEvents: [String : [CollectionSubscriber]] = [:]
//
//    override public func loadItem(at indexPath: IndexPath) {
//        publish(event: StoreEvent.didBeginLoading.rawValue)
//        fetch(didLoadSuccessfully: self.fetchSuccess, didFail: self.fetchDidFail)
//    }
//
//    override public func loadAll() {
//        publish(event: StoreEvent.didBeginLoading.rawValue)
//        fetchAll(didLoadSuccessfully: self.fetchAllSuccess, didFail: self.fetchDidFail)
//    }
//
//    private func fetchSuccess(fetchResults: EventData, indexPath: IndexPath) {
//        updateItem(at: indexPath, value: fetchResults)
//        publish(event: StoreEvent.didCompleteLoading.rawValue)
//        publish(event: StoreEvent.didLoadItem.rawValue, with: fetchResults)
//    }
//
//    private func fetchAllSuccess(fetchResults: ModelCollection) {
//        reload(with: fetchResults)
//        publish(event: StoreEvent.didCompleteLoading.rawValue)
//        publish(event: StoreEvent.didLoadItemCollection.rawValue, with: fetchResults)
//    }
//
//    private func fetchDidFail(error: StoreError) {
//        publish(event: String(error.hashValue))
//    }
//
//    public func publish(event: String, with eventCollectionData: ModelCollection) {
//        items = regroupIntoSections(given: eventCollectionData)
//        guard let subscriberActions = subscribedCollectionEvents[event] else { return }
//        subscriberActions.forEach { subscriber in subscriber.handler(event, eventCollectionData) }
//    }
//
//    public func updateItem(at indexPath: IndexPath, value: Model) {
//        guard indexPath.section >= 0 && indexPath.section < items.count &&
//            indexPath.row >= 0 && indexPath.row < items[indexPath.section].count else {
//                return
//        }
//        items[indexPath.section][indexPath.row] = value
//        publish(event: StoreEvent.didLoadItem.rawValue, with: value)
//    }
//
//    public func reload(with items: [Model]) {
//        self.items = regroupIntoSections(given: items)
//        publish(event: StoreEvent.didLoadItemCollection.rawValue, with: items)
//    }
//
//    /**********************************************************
//     MARK: Implement these methods to provide load functions
//     **********************************************************/
//    override open func fetch(didLoadSuccessfully: FetchOneSuccess, didFail: FetchFailure) {
//        didFail(.noImplementationProvided)
//    }
//
//    override open func fetchAll(didLoadSuccessfully: FetchAllSuccess, didFail: FetchFailure) {
//        didFail(.noImplementationProvided)
//    }
//    /**********************************************************/
//
//}
//
