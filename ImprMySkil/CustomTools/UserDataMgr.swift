//
//  UserDataMgr.swift
//  ImprMySkil
//
//  Created by Ejiajie on 16/4/15.
//  Copyright © 2016年 Ejiajie. All rights reserved.
//

import UIKit

private let mUserDataMgr = UserDataMgr()
class UserDataMgr: NSObject {
//    static let sharedInstance = UserDataMgr()
    
    var isDebug:NSInteger = 1
    var isNetWork:Bool = false
    var black_url_list:NSArray!
    class var sharedInstance: UserDataMgr {
        mUserDataMgr.isDebug = Int(AddPerfernces.sharedInstance.readFile("isDebug"))!
        return mUserDataMgr
    }
    
}
