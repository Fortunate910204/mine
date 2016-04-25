//
//  MySVProgressHUD.h
//  ejiajie
//
//  Created by 孙晓波 on 14/11/24.
//  Copyright (c) 2014年 wgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySVProgressHUD : UIView
+ (void)showSuccessWithStatus:(NSString *)string;
+ (void)showSuccessWithStatus:(NSString *)string duration:(NSTimeInterval)duration;
+ (MySVProgressHUD*)sharedView ;
@end
