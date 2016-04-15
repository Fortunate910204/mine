//
//  DataRequest.swift
//  ImprMySkil
//
//  Created by Ejiajie on 16/4/15.
//  Copyright © 2016年 Ejiajie. All rights reserved.
//

import UIKit

class DataRequest: NSObject {

    static let sharedInstance = DataRequest()
    
    func stringUrlToString(UrlString:String) -> String {
        #if !Debug
//            let baseUrl = ""
//            let subUrl = ""
            
            
        #endif
        return UrlString
    }
    
    func urlEncode(unEncodeString:String) -> String {
        let legalUrlCharactersToBeEscaped:CFStringRef = "&=;+!@#$()',*"
        return CFURLCreateStringByAddingPercentEscapes(nil, unEncodeString, nil, legalUrlCharactersToBeEscaped, CFStringBuiltInEncodings.UTF8.rawValue) as String
    }
    
    func addParameters(parameters:[String:AnyObject]? = nil) -> [String:AnyObject] {
        var parameters = parameters
        let defaultCity = AddPerfernces.sharedInstance.readFile("defaultCity")
        let defaultCityId = AddPerfernces.sharedInstance.readFile("defaultCityId")
        parameters!["operation_city_id"] = defaultCityId
        parameters!["city_name"] = defaultCity
        let access_token = AddPerfernces.sharedInstance.readFile("access_token")
        if !access_token.isEmpty {
            parameters!["access_token"] = access_token
        }
        let infoDict = NSBundle.mainBundle().infoDictionary
        let majorVersion = infoDict!["CFBundleShortVersionString"] as! String
        let app_version = "ios_user"+majorVersion
        parameters!["app_versin"] = app_version
        let order_channel_name = "ios_user5.0.0"
        parameters!["order_channel_name"] = order_channel_name
        let iOSVersionNum = UIDevice.currentDevice().systemVersion
        parameters!["iOSVersionNum"] = iOSVersionNum
        return parameters!
    }
    
}
