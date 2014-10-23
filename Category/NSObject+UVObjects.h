//
//  NSObject+UVObjects.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 13-8-29.
//  Copyright (c) 2013年 XXXX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MBProgressHUD,UVError;
@interface NSObject (UVObjects)
/**
 * 显示提示信息
 */
- (void)iToastMessage:(NSString*)message;
- (MBProgressHUD*)progress:(UIView*)view_ message:(NSString*)mess;
- (void)showError:(UVError*)error_;
@end
