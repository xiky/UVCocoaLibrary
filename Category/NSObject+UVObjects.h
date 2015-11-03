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
- (void)uv_iToastMessage:(NSString*)message;
- (MBProgressHUD*)uv_progress:(UIView*)view_ message:(NSString*)mess;
- (void)uv_showError:(UVError*)error_;

- (UIViewController*)uv_viewControllerWithStoryboard:(NSString*)storyboard_ identifier:(NSString*)identifier_;
@end
