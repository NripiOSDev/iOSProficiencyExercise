//
//  ServiceManager.swift
//  InterviewAssignment
//
//  Created by Nripendra singh on 13/01/19.
//  Copyright © 2019 Nripendra singh. All rights reserved.
//

import UIKit

let sharedSession = URLSession.shared
struct ServerSupportUrls{
    static let BASE_URL = "http://52.76.23.63:36936"
    
}

class ServiceManager: NSObject {
    
    static let sharedInstance = ServiceManager()
    
    fileprivate override init() {
        super.init()
    }
    
    //Create get url Request
    func CreateGetUrlRequest(_ url: String) -> NSMutableURLRequest{
        
        let urlString = url
        if let url = URL(string: urlString){
            let header = ["Content-Type": "application/json"]
            let urlRequest = NSMutableURLRequest(url: url as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 360)
            urlRequest.httpMethod = "Get"
            urlRequest.allHTTPHeaderFields = header
            return urlRequest
        }
        return NSMutableURLRequest()
    }
    
    func getallDataFromApi(contenturl: String, postCompleted : @escaping ( _ jsonDict:[String: AnyObject],  _ msg: NSInteger) -> ()) {
        
        
        let urlRequest = CreateGetUrlRequest(contenturl)
        let task = sharedSession.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
            if error != nil{
                //Handle error
                
            }else{
                let httpResponse = response as! HTTPURLResponse
                
                if let dataExist = data{
                    let responseData: Any?
                    do{
                        if httpResponse.statusCode == 200 {
                            responseData = try JSONSerialization.jsonObject(with: dataExist, options: .allowFragments)
                            if let responseDictData = responseData as? [String : AnyObject]{
                                postCompleted(responseDictData, httpResponse.statusCode)
                            }
                        }else{
                            postCompleted([:], httpResponse.statusCode)
                        }
                    }catch{
                        responseData = nil
                    }
                }
            }
        })
        task.resume()
    }
}
