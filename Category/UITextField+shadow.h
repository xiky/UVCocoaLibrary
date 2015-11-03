//
//  UITextField+shadow.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 14-5-16.
//  Copyright (c) 2014年 XXXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (shadow)

- (void)uv_addCursorBorder:(UIColor*)color;

/**
 *  使用自定义的背景
 *
 *  @param image_ 自定义的背景图片
 */
- (void)uv_applyCustomBackground:(UIImage*)image_;
@end
