//
//  UIColor+Utils.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 11/11/13.
//  Copyright (c) 2013 XXXX.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UVUtils)

/**
 * 使用十六进制颜色创建uicolor 
 *
 * @param NSString inColorString 十六制颜色 如cccccc
 * @return UIColor 返回UIColor
 */
+ (UIColor *) uv_colorFromHexRGB:(NSString *) inColorString;
@end
