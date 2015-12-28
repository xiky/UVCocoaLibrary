//
//  UVScrollView.m
//  UVCocoaLibrary
//
//  Created by ios on 15/9/30.
//  Copyright © 2015年 chnejiaixn. All rights reserved.
//

#import "UVScrollView.h"
@interface UVScrollView () <UIScrollViewDelegate>

@end


@implementation UVScrollView
#pragma mark - public
- (void)setViewControllers:(NSArray *)viewControllers_ size:(CGSize)size_
{
    _viewControllers = viewControllers_;
    
    self.delegate = self;
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    self.contentSize = CGSizeMake(size_.width * _viewControllers.count, size_.height);
    
    UIViewController *view;
    CGRect frame;
    for(NSInteger i=0; i<_viewControllers.count; i++)
    {
        view = _viewControllers[i];
        
        frame = view.view.frame;
        
        frame.origin.x = i * size_.width;
        view.view.frame = frame;
        [self addSubview:view.view];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    if(_pageDelegate != nil && [_pageDelegate respondsToSelector:@selector(onScrollViewPageChange:page:)])
    {
        [_pageDelegate onScrollViewPageChange:self page:page];
    }
    
}

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
