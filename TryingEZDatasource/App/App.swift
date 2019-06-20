//
//  App.swift
//  TryingEZDatasource
//
//  Created by Dominic Rodriquez on 7/11/18.
//  Copyright © 2018 Dominic Rodriquez. All rights reserved.
//

import Foundation
import COGuide
import AwesomeWeaponModel
import UIKit

class App: Observable {
    
    typealias Element = Context
    typealias Action = App.API
    
    static var sharedInstance = App()
    static var provider = AppProvider()
    
    var observers: [String : ObserverWrapper<Context, Action>] = [:]
    var value: Context = Context()
    
    init() {
        App.provider.startObserving { providerUpdate in
            self.publish(action: App.API.updateDatasource(datasourceContext: providerUpdate.value))
        }
    }
}

extension App {
    struct Context {
        var provider: AppProvider.Context = AppProvider.Context()
    }
    
    enum API {
        case refresh
        case updateDatasource(datasourceContext: AppProvider.Context)
    }
}


extension App {
    func update(with action: App.Action, from oldValue: Context) -> Context {
        var newValue = oldValue
        switch action {
        case .refresh: break
        case .updateDatasource(let provider):
            newValue.provider = provider
        }
        return newValue
    }
}


