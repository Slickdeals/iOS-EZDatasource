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
//                let model = try ParsedModel(payload: responsePayload)
//                // publish received data
//            }
//            catch let error {
//                print(error)
//            }
//        }
//    }
//}

// I have to implement the fetch given some request

// if I had a protocol that was an arrayProvider
// I am an arrayProvider where self Loadable

public enum ProviderError: Error {
    case noNetworkConnection
    case timeout
    case noImplementationProvided
    
    var message: String {
        switch self {
        case .noImplementationProvided:
            return "\(self): override and implement the fetch methods in order to use them"
        case .timeout:
            return "\(self): Received a timeout after giving it a go a few times"
        case .noNetworkConnection:
            return "\(self): no network man, fix that shit"
        }
    }
}

public protocol ArrayProvider: class, CollectionDataProvider {
    
    var items: [ModelCollection] { get set }
    
    init(array: ModelCollection)
    
    func regroupIntoSections(given modelItems: ModelCollection) -> [ModelCollection]
    
}

public extension ArrayProvider {
    
    public func regroupIntoSections(given modelItems: [Model]) -> [[Model]] {
        return [modelItems]
    }
    
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
    
    public func item(at indexPath: IndexPath) -> Model? {
        guard indexPath.section >= 0 && indexPath.section < items.count &&
            indexPath.row >= 0 && indexPath.row < items[indexPath.section].count else {
                return nil
        }
        return items[indexPath.section][indexPath.row]
    }
    
    public func updateItem(at indexPath: IndexPath, value: Model) {
        guard indexPath.section >= 0 && indexPath.section < items.count &&
            indexPath.row >= 0 && indexPath.row < items[indexPath.section].count else {
                return
        }
        items[indexPath.section][indexPath.row] = value
    }
    
    public func reload(with items: ModelCollection) {
        self.items = regroupIntoSections(given: items)
    }
    
}
