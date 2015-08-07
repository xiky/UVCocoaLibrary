//
//  UIImageView+Utils.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/8/4.
//  Copyright (c) 2015年 Uniview. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Utils)

- (void)imageWithRemoteUrl:(NSURL*)url_ holder:(UIImage*)holder_;
- (void)imageWithLocalUrl:(NSURL*)url_;
- (void)cleanCache:(NSURL*)url_;
@end
