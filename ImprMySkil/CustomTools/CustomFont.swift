//
//  CustomFont.swift
//  ImprMySkil
//
//  Created by Ejiajie on 16/4/13.
//  Copyright © 2016年 Ejiajie. All rights reserved.
//

import UIKit

class CustomFont: NSObject {
    
    static let sharedInstance = CustomFont()
    
    func customFontWithSize(fontSize:CGFloat) -> UIFont {
        let font = fontSize * CGRectGetWidth(UIScreen.mainScreen().bounds)/375
        return UIFont.systemFontOfSize(font)
    }

}
