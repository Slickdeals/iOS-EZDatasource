//
//  CollectionDatasource+Reactive.swift
//  EZDatasources
//
//  Created by Dominic Rodriquez on 7/17/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit

open class ReactiveCollectionDatasource<Provider: ExplicitEventBroker & CollectionDataProvider, Cell: UICollectionViewCell>: CollectionDataSource<Provider, Cell>, ExplicitEventBroker
where Cell: EZCell, Provider.Model == Cell.Model, Provider.EventData == Provider.Model {
    
    public typealias EventData = Provider.EventData
    public typealias EventDataCollection = Provider.EventDataCollection
    public typealias Subscriber = ExplicitSubscriberAction<EventData>
    public typealias CollectionSubscriber = ExplicitSubscriberAction<EventDataCollection>
    
    public var eventsAvailable: [String] {
        get { return provider.eventsAvailable }
        set { provider.eventsAvailable = newValue }
    }
    
    public var basicSubscribedEvents: [String : [BasicSubscriberAction]] = [:]
    
    public var subscribedEvents: [String : [Subscriber]] = [:]
    
    public var subscribedCollectionEvents: [String : [CollectionSubscriber]] = [:]
    
    override public func setup() {
        super.setup()
        subscribeToProvider()
    }
    
    private func subscribeToProvider() {
        eventsAvailable.forEach { eventName in subscribeAll(with: eventName) }
    }
    
    private func subscribeAll(with eventName: String) {
        provider.subscribe(to: eventName, subscriber: self, with: self.didReceiveEvent)
        provider.subscribe(to: eventName, subscriber: self, with: self.didReceiveItemEvent)
        provider.subscribe(to: eventName, subscriber: self, with: self.didReceiveCollectionEvent)
    }
    
    public func didReceiveEvent(eventName: String) {
        publish(event: eventName)
    }
    
    public func didReceiveItemEvent(eventName: String, eventData: Provider.EventData) {
        DispatchQueue.main.async { self.collectionView.reloadData() }
        publish(event: eventName, with: eventData)
    }
    
    public func didReceiveCollectionEvent(eventName: String, eventData: EventDataCollection) {
        DispatchQueue.main.async { self.collectionView.reloadData() }
        publish(event: eventName, with: eventData)
    }
    
    public override init(collectionView: UICollectionView, provider: Provider, cellDelegate: Cell.Delegate? = nil) {
        super.init(collectionView: collectionView, provider: provider, cellDelegate: cellDelegate)
    }
    
    public func loadAll() {
        provider.loadAll()
    }
}
