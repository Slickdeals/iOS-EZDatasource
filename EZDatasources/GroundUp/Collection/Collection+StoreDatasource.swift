//
//  Collection+StoreDatasource.swift
//  EZDatasources
//
//  Created by Dominic Rodriquez on 11/27/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation

//open class StoreDatasource<Store: ObservableReducer & CollectionInterface, Cell: UICollectionViewCell>: CollectionDataStore<Store, Cell>

//
//open class ReactiveCollectionDatasource<Store: ExplicitEventBroker & CollectionDataStore, Cell: UICollectionViewCell>: CollectionDataSource<Store, Cell>, ExplicitEventBroker
//where Cell: EZCell, Store.Model == Cell.Model, Store.EventData == Store.Model {
//
//    public typealias EventData = Store.EventData
//    public typealias EventDataCollection = Store.EventDataCollection
//    public typealias Subscriber = ExplicitSubscriberAction<EventData>
//    public typealias CollectionSubscriber = ExplicitSubscriberAction<EventDataCollection>
//
//    public var eventsAvailable: [String] {
//        get { return store.eventsAvailable }
//        set { store.eventsAvailable = newValue }
//    }
//
//    public var basicSubscribedEvents: [String : [BasicSubscriberAction]] = [:]
//
//    public var subscribedEvents: [String : [Subscriber]] = [:]
//
//    public var subscribedCollectionEvents: [String : [CollectionSubscriber]] = [:]
//
//    override public func setup() {
//        super.setup()
//        subscribeToStore()
//    }
//
//    private func subscribeToStore() {
//        eventsAvailable.forEach { eventName in subscribeAll(with: eventName) }
//    }
//
//    private func subscribeAll(with eventName: String) {
//        store.subscribe(to: eventName, subscriber: self, with: self.didReceiveEvent)
//        store.subscribe(to: eventName, subscriber: self, with: self.didReceiveItemEvent)
//        store.subscribe(to: eventName, subscriber: self, with: self.didReceiveCollectionEvent)
//    }
//
//    public func didReceiveEvent(eventName: String) {
//        publish(event: eventName)
//    }
//
//    public func didReceiveItemEvent(eventName: String, eventData: Store.EventData) {
//        DispatchQueue.main.async { self.collectionView.reloadData() }
//        publish(event: eventName, with: eventData)
//    }
//
//    public func didReceiveCollectionEvent(eventName: String, eventData: EventDataCollection) {
//        DispatchQueue.main.async { self.collectionView.reloadData() }
//        publish(event: eventName, with: eventData)
//    }
//
//    public override init(collectionView: UICollectionView, store: Store, cellDelegate: Cell.Delegate? = nil) {
//        super.init(collectionView: collectionView, store: store, cellDelegate: cellDelegate)
//    }
//
//    public func loadAll() {
//        store.loadAll()
//    }
//}
