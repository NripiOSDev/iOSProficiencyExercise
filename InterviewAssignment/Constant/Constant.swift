//
//  Constant.swift
//  InterviewAssignment
//
//  Created by Nripendra singh on 13/01/19.
//  Copyright © 2019 Nripendra singh. All rights reserved.
//

import UIKit

class Constant: NSObject {
    struct ApiUrls {
        static let baseUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    }
    struct ApiKeys {
        static let title = "title"
        static let description = "description"
        static let imageUrl = "imageHref"
        static let rows = "rows"
    }
    struct LoaderMessage {
        static let message = ""
    }
    struct TableViewKeys {
        static let cellReuseIdentifier = "customCell"
        static let cellEstimatedHeight = 100
    }
    struct ErrorMessage {
        static let messageText = "Something went wrong with internet. Please check your internet connection and try again"
        static let messageTitle = "Message"
        static let messageActionText = "Ok"
    }
    struct ApiResponseCode {
        static let Success = 200
    }
    struct DefaultValue {
        static let text = ""
        static let tableviewEmptyMessage = "No data available"
    }
    
    
}
