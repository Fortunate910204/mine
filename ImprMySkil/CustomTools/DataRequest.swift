//
//  DataRequest.swift
//  ImprMySkil
//
//  Created by Ejiajie on 16/4/15.
//  Copyright © 2016年 Ejiajie. All rights reserved.
//

import UIKit
import Alamofire


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

    func GETRequest(urlString:URLStringConvertible,
                    parameters: [String: AnyObject]? = nil,
                    CacheKey:String,
                    Success:(Response:AnyObject, isCacheKey:Bool) -> Void,
                    Failure:AnyObject -> Void) {
        if !CacheKey .isEmpty {
            let user:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            let responseObjectDict = user.objectForKey(CacheKey as String)
            if responseObjectDict != nil {
                Success(Response: responseObjectDict!, isCacheKey: true)
            }
        }
        Alamofire.request(.GET, urlString, parameters: parameters).responseJSON { Response in
            switch Response.result{
            case .Success:
                Success(Response: Response.result.value!, isCacheKey: false)
                if !CacheKey.isEmpty{
                    let user:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    user.setObject(Response.result.value, forKey: CacheKey)
                    print("Alamofire  CacheSuccess --->>"+(Response.request?.URLString)!)
                }else{
                    print("Alamofire  CacheFailure"+(Response.request?.URLString)!)
                }
                break
            
            case .Failure(let error):
                print("Alamofire Failure --->>"+(Response.request?.URLString)!)
                Failure(error)
                break
            }
        }
    }
    
    func POSTRequest(urlString:URLStringConvertible,
                     parameters:[String: AnyObject]? = nil,
                     CacheKey: NSString,
                     Success:(Response:AnyObject, isCachekey:Bool) -> Void,
                     Failure:AnyObject -> Void)
    {
        if CacheKey != "" {
            let user:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            let responseObjectDict = user.objectForKey(CacheKey as String)
            if responseObjectDict != nil {
                Success(Response: responseObjectDict!, isCachekey: true)
            }
        }
        Alamofire.request(.POST, urlString, parameters: parameters).responseJSON { Response in
            switch Response.result{
            case .Success:
                Success(Response: Response.result.value!, isCachekey: false)
                if CacheKey != ""{
                    let user:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    user.setObject(Response.result.value, forKey: CacheKey as String)
                    print("Alamofire  CacheSuccess --->>"+(Response.request?.URLString)!)
                }else{
                    print("Alamofire  CacheFailure --->>"+(Response.request?.URLString)!)
                }
                break
            
            case .Failure(let error):
                print("Alamofire Failure --->>"+(Response.request?.URLString)!)
                Failure(error)
                break
            }
        }
    }
    
    func getLoginPost(urlString: URLStringConvertible,
                      parameters: [String: AnyObject]? = nil,
                      cacheKey: String,
                      success: (Response: AnyObject, isCacheKey:Bool) -> Void,
                      failure: AnyObject -> Void){
        let parameters = self.addParameters(parameters)
        POSTRequest(urlString, parameters: parameters, CacheKey: cacheKey, Success: success, Failure: failure)
        
    }
    
    func getUserInit(urlString: URLStringConvertible,
                     parameters: [String: AnyObject]? = nil,
                     cacheKey:String,
                     success: (Response: AnyObject, isCacheKey:Bool) -> Void,
                     failure: AnyObject -> Void){
//        let parameters = self.addParameters(parameters)
        let parameters = addParameters(parameters)
        GETRequest(urlString, parameters: parameters, CacheKey: cacheKey, Success: success, Failure: failure)
    }
    
    func getUserInitBegin(urlString: URLStringConvertible,
                          parameters: [String: AnyObject]? = nil,
                          cacheKey: String,
                          succesee: (Response: AnyObject, isCacheKey:Bool) -> Void,
                          failure: AnyObject -> Void){
        let parameters = addParameters(parameters)
        GETRequest(urlString, parameters: parameters, CacheKey: cacheKey, Success: succesee, Failure: failure)
    }
    
    func getSendMessageCode(urlString: URLStringConvertible,
                            parameters: [String: AnyObject]? = nil,
                            cacheKey: String,
                            success: (Response: AnyObject, isCacheKey:Bool) -> Void,
                            failure: AnyObject -> Void){
        let parameters = addParameters(parameters)
        GETRequest(urlString, parameters: parameters, CacheKey: cacheKey, Success: success, Failure: failure)
    }
    
    func getBaiduMap(urlString: URLStringConvertible,
                     parameters: [String: AnyObject]? = nil,
                     cacheKey: String,
                     success: (Response: AnyObject, isCacheKey:Bool) -> Void,
                     failure: AnyObject -> Void){
        let parameters = addParameters(parameters)
        GETRequest(urlString, parameters: parameters, CacheKey: cacheKey, Success: success, Failure: failure)
    }
    
    
    
    
    
    
    
}
