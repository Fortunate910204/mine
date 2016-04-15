//
//  AddPerfernces.swift
//  ImprMySkil
//
//  Created by Ejiajie on 16/4/13.
//  Copyright © 2016年 Ejiajie. All rights reserved.
//

import UIKit

class AddPerfernces: NSObject {
    
    static let sharedInstance = AddPerfernces()
    
    
    func writeFileStoreKey(file:String, storeKey:String) {
        let fileMgr = NSFileManager.defaultManager()
        let pathes = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true) [0] as NSString
        let documentDir = pathes.stringByAppendingPathComponent("myFileDir")
        
        var isDir = ObjCBool(false)
        let isExisted = fileMgr.fileExistsAtPath(documentDir, isDirectory: &isDir)
        if isDir.boolValue == false && isExisted == false {
            do{
                try fileMgr.createDirectoryAtPath(documentDir, withIntermediateDirectories: true, attributes: nil)
            }catch{
                print("AddPerfernces ----> Error")
            }
        }
        
        fileMgr.changeCurrentDirectoryPath(documentDir)
        let path = NSString!(documentDir) .stringByAppendingPathComponent("storeKey")
        let writter = NSMutableData()
        let tempStr = String(format: "%@", file)
        writter.appendData(tempStr.dataUsingEncoding(NSUTF8StringEncoding)!)
        
        writter .writeToFile(path, atomically: true)
    }
    
    func readFile(stroeKey:String) -> String {
        let fileMgr = NSFileManager.defaultManager()
        let pathes = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true) [0] as NSString
        let  documentDir = pathes.stringByAppendingPathComponent("myFileDir")
        
        fileMgr.changeCurrentDirectoryPath(documentDir)
        let path = NSString!(documentDir).stringByAppendingPathComponent("storeKey")
        var reader = NSData()
        do{
            try reader = NSData.init(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
        }catch{
            reader = NSData()
        }
        return String(data: reader, encoding: NSUTF8StringEncoding)!
    }
}
