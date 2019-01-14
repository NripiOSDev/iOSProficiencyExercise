//
//  ServiceManager.swift
//  InterviewAssignment
//
//  Created by Nripendra singh on 13/01/19.
//  Copyright © 2019 Nripendra singh. All rights reserved.
//
import UIKit

let sharedSession = URLSession.shared
class ServiceManager: NSObject {
    
    static let sharedInstance = ServiceManager()
    
    fileprivate override init() {
        super.init()
    }
    
    //Create get url Request
    func CreateGetUrlRequest(_ url: String) -> NSMutableURLRequest{
        let urlString = url
        if let url = URL(string: urlString){
            let header = ["Content-Type": "text/plain"]
            let urlRequest = NSMutableURLRequest(url: url as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 360)
            urlRequest.httpMethod = "Get"
            urlRequest.allHTTPHeaderFields = header
            return urlRequest
        }
        return NSMutableURLRequest()
    }
    
    func getallDataFromApi(contenturl: String, getCompleted : @escaping ( _ jsonDict:[String: AnyObject],  _ msg: NSInteger) -> ()) {
        let urlRequest = CreateGetUrlRequest(contenturl)
        let task = sharedSession.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
            if error != nil{
                //Handle error
                
            }else{
                let httpResponse = response as! HTTPURLResponse
                
                if let dataExist = data{
                    let responseData: Any?
                    do{
                        if httpResponse.statusCode == Constant.ApiResponseCode.Success {
                            let responseStrInISOLatin = String(data:dataExist, encoding: String.Encoding.isoLatin1)
                            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                                print("could not convert data to UTF-8 format")
                                return
                            }
                            responseData = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format, options: .allowFragments)
                            if let responseDictData = responseData as? [String : AnyObject]{
                                getCompleted(responseDictData, httpResponse.statusCode)
                            }
                        }else{
                            getCompleted([:], httpResponse.statusCode)
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
