//
//  UVUtils.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 13-8-21.
//  Copyright (c) 2013年 XXXX. All rights reserved.
//
#import "UVUtils.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

@implementation UVUtils

+ (NSString *)md5passwd:(NSString*)str_
{

        
    const char *cpass = [str_ UTF8String];
    unsigned char result[32];
    CC_MD5(cpass, (uint)strlen(cpass), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];

}

- (UIViewController *)topViewController
{
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //当前不是正常window，获取第一个找到正常window
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIViewController *appRootVC = window.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController)
    {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}
@end
