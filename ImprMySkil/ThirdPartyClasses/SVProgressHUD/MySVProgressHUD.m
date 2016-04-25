//
//  MySVProgressHUD.m
//  ejiajie
//
//  Created by 孙晓波 on 14/11/24.
//  Copyright (c) 2014年 wgq. All rights reserved.
//

#import "MySVProgressHUD.h"
@interface MySVProgressHUD ()
@property (nonatomic, assign) NSTimer *fadeOutTimer;
@property (nonatomic, strong) UIView *hudView;
@property (nonatomic, strong) UILabel *stringLabel;
@property (nonatomic, strong) UIView *coverView;
@end
@implementation MySVProgressHUD
@synthesize  hudView, fadeOutTimer, stringLabel;
- (void)dealloc {
    if (self.fadeOutTimer != nil) {
        [self.fadeOutTimer invalidate];
        self.fadeOutTimer = nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
+ (MySVProgressHUD*)sharedView {
    static dispatch_once_t once;
    static MySVProgressHUD *sharedView;
    dispatch_once(&once, ^ {
        sharedView = [[MySVProgressHUD alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return sharedView;
}
+ (void)showSuccessWithStatus:(NSString *)string{
    if (string.length >= 2) {
        if ([string rangeOfString:@"(null)"].location==NSNotFound) {
            [[MySVProgressHUD sharedView] show];
            [[MySVProgressHUD sharedView] dismissWithStatus:string afterDelay:2.0f];
        }
    }
}

+ (void)showSuccessWithStatus:(NSString *)string duration:(NSTimeInterval)duration {
    if (string.length >= 2) {
        [[MySVProgressHUD sharedView] show];
        [[MySVProgressHUD sharedView] dismissWithStatus:string afterDelay:duration];
    }
}
#pragma mark - Instance Methods

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithWhite:0 alpha:0] set];
    CGContextFillRect(context, self.bounds);
}
- (UIView *)hudView {
    if(!hudView) {
        hudView = [[UIView alloc] initWithFrame:CGRectZero];
        hudView.layer.cornerRadius = 5;
        hudView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        hudView.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin |
                                    UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin);
        
        [self addSubview:hudView];
    }
    return hudView;
}

- (UILabel *)stringLabel {
    if (stringLabel == nil) {
        stringLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        stringLabel.textColor = [UIColor whiteColor];
        stringLabel.backgroundColor = [UIColor clearColor];
        stringLabel.adjustsFontSizeToFitWidth = YES;
        stringLabel.textAlignment = NSTextAlignmentCenter;
        stringLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        stringLabel.font = [UIFont boldSystemFontOfSize:16];
        stringLabel.shadowColor = [UIColor blackColor];
        stringLabel.shadowOffset = CGSizeMake(0, -1);
        stringLabel.numberOfLines = 0;
    }
    if(!stringLabel.superview)
        [self.hudView addSubview:stringLabel];
    
    return stringLabel;
}

-(void)show{
    [self dismiss];
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!self.superview){
            UIView *window = [[UIApplication sharedApplication].windows objectAtIndex:[UIApplication sharedApplication].windows.count -1];
            if (window.tag != 119) {
                [window addSubview:self.hudView];
            }else{
                UIView *window = [[UIApplication sharedApplication].windows objectAtIndex:[UIApplication sharedApplication].windows.count -2];
                [window addSubview:self.hudView];
            }
        }
        if(self.alpha != 1) {
            self.hudView.transform = CGAffineTransformScale(self.hudView.transform, 0.5, 0.5);
            [UIView animateWithDuration:0.15
                                  delay:0
                                options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                                 self.hudView.transform = CGAffineTransformScale(self.hudView.transform, 1/0.5, 1/0.5);
                                 self.alpha = 1;
                             }
                             completion:NULL];
        }
        [self setNeedsDisplay];
    });
}
- (void)dismissWithStatus:(NSString *)string afterDelay:(NSTimeInterval)seconds {
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.alpha != 1)
            return;
        CGFloat hudWidth = 100;
        CGFloat hudHeight = 100;
        CGFloat stringWidth = 0;
        CGFloat stringHeight = 0;
        CGRect labelRect = CGRectZero;
        if(string) {
            NSDictionary *attributes = @{NSFontAttributeName:self.stringLabel.font};
            CGSize stringSize = [string  boundingRectWithSize:CGSizeMake(260, 300) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
            stringWidth = stringSize.width;
            stringHeight = stringSize.height;
            hudHeight = 20+stringHeight;
            if(stringWidth > hudWidth)
                hudWidth = ceil(stringWidth/2)*2;
            if(hudHeight < 100) {
                labelRect = CGRectMake(10, 10, hudWidth, stringHeight);
                hudWidth+=24;
            } else {
                hudWidth+=24;
                labelRect = CGRectMake(0, 10, hudWidth, stringHeight);
            }
        }
        self.hudView.bounds = CGRectMake(0, 0, hudWidth, hudHeight);
        [self positionHUD];
        self.stringLabel.hidden = NO;
        self.stringLabel.text = string;
        self.stringLabel.frame = labelRect;
        self.fadeOutTimer = [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
    });
}

- (void)positionHUD{
    CGRect orientationFrame = [UIScreen mainScreen].bounds;
    CGFloat activeHeight = orientationFrame.size.height;          //距离下边距离
    CGFloat posY = activeHeight/2;// - self.hudView.bounds.size.height/2 -60;
    CGFloat posX = orientationFrame.size.width/2;
    CGPoint newCenter;
    CGFloat rotateAngle;
    rotateAngle = 0.0;
    newCenter = CGPointMake(posX, posY);
    [self moveToPoint:newCenter rotateAngle:rotateAngle];
    
}
- (void)moveToPoint:(CGPoint)newCenter rotateAngle:(CGFloat)angle {
    self.hudView.transform = CGAffineTransformMakeRotation(angle);
    self.hudView.center = newCenter;
}
- (void)dismiss {
    if (self.fadeOutTimer != nil) {
        [self.fadeOutTimer invalidate];
        self.fadeOutTimer = nil;
    }else{
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.15
                              delay:0
                            options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             self.hudView.transform = CGAffineTransformScale(self.hudView.transform, 0.8, 0.8);
                             self.alpha = 0;
                         }
                         completion:^(BOOL finished){
                             if(self.alpha == 0) {
                                 [[NSNotificationCenter defaultCenter] removeObserver:self];
                                 [hudView removeFromSuperview];
                                 hudView = nil;
                                 NSMutableArray *windows = [[NSMutableArray alloc] initWithArray:[UIApplication sharedApplication].windows];
                                 [windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIWindow *window, NSUInteger idx, BOOL *stop) {
                                     if([window isKindOfClass:[UIWindow class]] && window.windowLevel == UIWindowLevelNormal) {
                                         [window makeKeyWindow];
                                         *stop = YES;
                                     }
                                 }];
                             }
                         }];
    });
}

@end
