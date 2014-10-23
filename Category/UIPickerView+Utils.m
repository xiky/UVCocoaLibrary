//
//  UIPickerView+Utils.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 11/12/13.
//  Copyright (c) 2013 XXXX.com. All rights reserved.
//

#import "UIPickerView+Utils.h"

@implementation UIPickerView (Utils)

- (void)hide:(void (^)(void))block
{
    [UIView animateWithDuration:1.f animations:^{
        CGRect frame = self.frame;
        frame.origin.y = [[UIScreen mainScreen] bounds].size.height;
        self.frame = frame;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        if(block != nil)
        {
            block();
        }
    }];
}
- (void)show:(void (^)(void))block
{
    //如果是已经显示了，则要先隐藏再显示
    if(self.hidden == NO)
    {
        [self hide:^{
            [self show:nil];
        }];
        return;
    }
    self.hidden= NO;
    [UIView animateWithDuration:1.f animations:^{
        CGRect frame = self.frame;
        frame.origin.y = [[UIScreen mainScreen] bounds].size.height - frame.size.height;
        if(frame.origin.y<18)frame.origin.y=18;
        self.frame = frame;
    } completion:^(BOOL finished) {
        if(block != nil)
        {
            block();
        }
    }];
}
@end
