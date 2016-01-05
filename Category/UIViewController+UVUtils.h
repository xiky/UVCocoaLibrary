//
//  UIViewController+UVUtils.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 10/18/13.
//  Copyright (c) 2013 XXXX.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (UVUtils)

/**
 * 在视图上增加事件 点击视图自动隐藏键盘
 */
-(void)uv_addTapHideKeyBroard;

/**
 *  设置自定义的左边按钮  去掉系统默认的多余的左边间距
 *
 *  @param item_ UIBarButtonItem
 */
- (void)uv_setCustomLeftButtom:(UIBarButtonItem*)item_;


@end
