//
//  UVUtils.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 13-8-21.
//  Copyright (c) 2013年 XXXX. All rights reserved.
//
#import "UVUtils.h"
#import <UIKit/UIKit.h>


@implementation UVUtils


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
