//
//  ArrayProvider.swift
//  SlickdealsCore
//
//  Created by Dominic Rodriquez on 6/21/18.
//  Copyright © 2018 Slickdeals, LLC. All rights reserved.
//

import Foundation
import UIKit

//public protocol APIRequestPayload: Codable {
//    associatedtype Payload
//    var requestPayload: Payload { get set }
//}
//
//public protocol APIResponsePayload: Codable {
//    associatedtype Payload
//    var responsePayload: Payload { get set }
//}
//
//
//public protocol ComposableFromPayload: Codable {
//    associatedtype Payload
//    init(payload: Payload) throws
//}
//
//public protocol APIModelRetriever {
//    associatedtype RequestPayload: APIRequestPayload
//    associatedtype ResponsePayload: APIResponsePayload
//    associatedtype ParsedModel: ComposableFromPayload where ParsedModel.Payload == ResponsePayload.Payload
//    
//    typealias ResponseHandler = (ResponsePayload) -> Void
//    
//    func fetch(with request: RequestPayload)
//    
//    func handleRequest(with payload: RequestPayload, completion: ResponseHandler)
//}
//
//public extension APIModelRetriever {
//    
//    public func fetch(with request: RequestPayload) {
//        handleRequest(with: request) { responsePayload in
//            do {
//                let model = try ParsedModel.init//(payload: responsePayload)
//            }
//            catch let error {
//                print(error)
//            }
//        }
//    }
//    
//}

// I have to implement the fetch given some request

public protocol ArrayProvider: class, CollectionDataProvider where Self.ItemType == Self.Model {
    
    associatedtype ItemType
    
    var items: [[ItemType]] { get set }
    
    init(array: [[ItemType]])
    
    //func load()
    
}

public extension ArrayProvider {
    
    // MARK: - CollectionDataProvider
    public func numberOfSections() -> Int {
        return items.count
    }
    
    public func numberOfItems(in section: Int) -> Int {
        guard section >= 0 && section < items.count else {
            return 0
        }
        return items[section].count
    }
    
    public func item(at indexPath: IndexPath) -> ItemType? {
        guard indexPath.section >= 0 && indexPath.section < items.count &&
            indexPath.row >= 0 && indexPath.row < items[indexPath.section].count else {
                return nil
        }
        return items[indexPath.section][indexPath.row]
    }
    
    public func updateItem(at indexPath: IndexPath, value: ItemType) {
        guard indexPath.section >= 0 && indexPath.section < items.count &&
            indexPath.row >= 0 && indexPath.row < items[indexPath.section].count else {
                return
        }
        items[indexPath.section][indexPath.row] = value
    }
    
    public func reload(with items: [[ItemType]]) {
        self.items = items
        //self.delegate?.didUpdateItems()
    }
    
}
