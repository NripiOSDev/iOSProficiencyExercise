//
//  RootViewModel.swift
//  InterviewAssignment
//
//  Created by Nripendra singh on 16/01/19.
//  Copyright © 2019 Nripendra singh. All rights reserved.
//


protocol RootViewModelDelegate {
    func rootViewModelRecieveData(_ infoData: [CanadaInfoModel.CanadaData], _ navigattionTitle: String, _ error: String)
}

import UIKit

class RootViewModel: NSObject {
    var delegate: RootViewModelDelegate?
    
    // MARK: - Api call for geting data
    func getImagesData(apiUrl: String) -> Void{
        ServiceManager.sharedInstance.getallDataFromApi(contenturl:apiUrl, getRequestCompleted: { [weak self] (responseData, responseCode) in
            
            if responseCode == Constant.ApiResponseCode.Success{
                if let responseDict = responseData[Constant.ApiKeys.rows] as? [[String : AnyObject]]{
                    var model = [CanadaInfoModel.CanadaData]()
                    model = responseDict.compactMap{ (dictionary) in
                        return CanadaInfoModel.CanadaData(dictionary)
                    }
                    let navTitle = responseData[Constant.ApiKeys.title] as? String
                    self?.delegate?.rootViewModelRecieveData(model,navTitle ?? Constant.DefaultValue.text, Constant.DefaultValue.text )
                }
            }
            else{
                self?.delegate?.rootViewModelRecieveData([CanadaInfoModel.CanadaData](),Constant.DefaultValue.text ,Constant.ErrorMessage.messageText)
            }
        })
    }
}
