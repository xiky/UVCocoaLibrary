//
//  YKModelView.m
//  YKActionSheet.h YKActionSheet
//
//  Created by chenjiaxin on 15/10/29.
//  Copyright © 2015年 chenjiaxin. All rights reserved.
//

#import "UVModelView.h"

@implementation UVModelView
{
    BOOL _isadd;
}

- (id)initWithChildView:(UIView*)view_
{
    if(self = [super init])
    {
        
        _childView = view_;
        self.backgroundColor = [UIColor grayColor];
        
        self.alpha = 0.9f;
        self.userInteractionEnabled = YES;
        _isShow = NO;
        _isadd = NO;
        _autoHidden = YES;
        _animateDuration = 0.5f;
        _childView.userInteractionEnabled = YES;
        [self addSubview:_childView];
        
    }
    return self;
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGPoint buttonPoint = [_childView convertPoint:point fromView:self];
    
    if(![_childView pointInside:buttonPoint withEvent:event] && _autoHidden)
    {
        [self hide];
    }

}

- (void)showInSupperView:(UIView*)view_
{
    if(_isShow)
    {
        return;
    }

    [view_ addSubview:self];
    _isadd = YES;

    CGRect frame = view_.frame;
    frame.origin.x = 0.f;
    frame.origin.y = 0.f;
    self.frame = frame;
    
    frame = _childView.frame;
    frame.origin.y = self.frame.size.height;
    _childView.frame = frame;
    
    
    _isShow = YES;
    _childView.hidden = NO;
    [self bringSubviewToFront:_childView];
    self.hidden = NO;
    [UIView animateWithDuration:_animateDuration animations:^{
        CGRect frame = _childView.frame;
        frame.origin.y = self.frame.size.height - frame.size.height;
        _childView.frame = frame;
    }];
}
- (void)hide
{
    if(!_isShow)return;
    _isShow = NO;
    [UIView animateWithDuration:_animateDuration animations:^{
        CGRect frame = _childView.frame;
        frame.origin.y = self.frame.size.height;
        _childView.frame = frame;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self triggerHide];
    }];
}

- (void)triggerHide
{
    if(_delegate && [_delegate respondsToSelector:@selector(onUVModelViewHide:)])
    {
        [_delegate onUVModelViewHide:self];
    }
}
@end
