//
//  FileterdWebCache.swift
//  ImprMySkil
//
//  Created by Ejiajie on 16/4/19.
//  Copyright © 2016年 Ejiajie. All rights reserved.
//

import UIKit

private let customUrlCacheExpirationKey = "customUrlCacheExpiration"
private let customUrlCacheExpirationInterval:NSTimeInterval = 3600

private let memoryCapacity = 2*1024*1024
private let diskCapacity = 100*1024*1024
private let mFilteredWebCache = FileterdWebCache.init(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: nil)

class FileterdWebCache: NSURLCache {
    class var sharedInstance:FileterdWebCache {
        return mFilteredWebCache
    }
    
//    override func cachedResponseForRequest(request: NSURLRequest) -> NSCachedURLResponse? {
//        let urlString = request.URL?.absoluteString
//        let url:NSMutableString = NSMutableString.init(string:urlString!)
//        let mUserDataMgr = UserDataMgr.sharedInstance
//        if mUserDataMgr.black_url_list != nil{
//            for fileNameString in mUserDataMgr.black_url_list {
//                if url.rangeOfString(fileNameString as String).length != 0 {
//                    
//                    
//                }
//            }
//        }
//       
//    }
}
