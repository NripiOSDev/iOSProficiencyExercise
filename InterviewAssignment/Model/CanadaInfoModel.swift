//
//  CanadaInfoModel.swift
//  InterviewAssignment
//
//  Created by Nripendra singh on 14/01/19.
//  Copyright © 2019 Nripendra singh. All rights reserved.
//

import UIKit

class CanadaInfoModel: NSObject {
    struct CanadaData {
        var title: String
        var description: String
        var imageUrl: String
        
        init(_ dictionary: [String: Any]) {
            self.title = dictionary[Constant.ApiKeys.title] as? String ?? ""
            self.description = dictionary[Constant.ApiKeys.description] as? String ?? ""
            self.imageUrl = dictionary[Constant.ApiKeys.imageUrl] as? String ?? ""
        }
    }
}
