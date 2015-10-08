//
//  UVScrollView.m
//  UVCocoaLibrary
//
//  Created by ios on 15/9/30.
//  Copyright © 2015年 chnejiaixn. All rights reserved.
//

#import "UVScrollView.h"

@implementation UVScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *result = [super hitTest:point withEvent:event];
    
    for(UIView *view in _touchviews)
    {
        CGPoint buttonPoint = [view convertPoint:point fromView:self];
        if ([view pointInside:buttonPoint withEvent:event])
        {
            self.scrollEnabled = NO;
            return view;
        }
    }
    self.scrollEnabled = YES;
    return result;
}
@end
