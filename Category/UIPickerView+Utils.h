//
//  UIPickerView+Utils.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 11/12/13.
//  Copyright (c) 2013 XXXX.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPickerView (Utils)

/**
 * 从底部隐藏pickerview
 */
- (void)hide:(void (^)(void))block;
/**
 * 从底部显示pickerview
 */
- (void)show:(void (^)(void))block;
@end
