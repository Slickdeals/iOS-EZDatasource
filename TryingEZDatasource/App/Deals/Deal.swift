//
//  Deal.swift
//  TryingEZDatasource
//
//  Created by Dominic Rodriquez on 1/3/19.
//  Copyright © 2019 Dominic Rodriquez. All rights reserved.
//

import Foundation
import UIKit
import COGuide

protocol GuidedLayoutModel: GuidedModel {
    var defaultFormat: Format { get }
}

struct Deal: GuidedLayoutModel, ImageTitleSubtitle {
    var titleText: String
    var extra: String
    var dealImage: UIImage
    
    var defaultFormat: Format { return .imageTitleSubtitle }
    
    var title: String {
        get {
            return titleText
        }
        set {
            titleText = newValue
        }
    }
    
    var subtitle: String {
        get {
            return extra
        }
        set {
            extra = newValue
        }
    }
    
    var image: UIImage { 
        get {
            return dealImage
        }
        set {
            dealImage = newValue
        }
    }
}

struct Article: GuidedLayoutModel, ImageTitleSubtitle {
    var articleHeading: String
    var details: String
    var articleImg: UIImage
    
    var defaultFormat: Format { return .imageTitle }
    
    var title: String {
        get {
            return articleHeading
        }
        set {
            articleHeading = newValue
        }
    }
    
    var subtitle: String {
        get {
            return details
        }
        set {
            details = newValue
        }
    }
    
    var image: UIImage {
        get {
            return articleImg
        }
        set {
            articleImg = newValue
        }
    }
}
