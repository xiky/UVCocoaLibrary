//
//  UVTableView.m
//  testTableview
//
//  Created by chenjiaxin on 15/12/23.
//  Copyright © 2015年 chenjaixin. All rights reserved.
//

#import "UVTableView.h"

@interface UVTableView ()
@property (nonatomic,assign) UITableViewCellSeparatorStyle oldSepStyle;
@end

@implementation UVTableView

- (void)setEmptyView:(UIView *)emptyView_
{
    if(_emptyView != nil)
    {
        [_emptyView removeFromSuperview];
    }
    _emptyView = emptyView_;
    
    _emptyView.userInteractionEnabled = YES;
    _emptyView.hidden = YES;
    [self addSubview:_emptyView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onEmptyViewTap:)];
    [_emptyView addGestureRecognizer:tap];
}

- (void)setFailureView:(UIView *)failureView_
{
    if(_failureView != nil)
    {
        [_failureView removeFromSuperview];
    }
    _failureView = failureView_;
    _failureView.hidden = YES;
    _failureView.userInteractionEnabled = YES;
    
    [self addSubview:_failureView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onFailureViewTap:)];
    [_failureView addGestureRecognizer:tap];
}


- (void)showEmptyView:(BOOL)status_
{
    if(_emptyView == nil)return;
    if(status_)
    {
        if(!_emptyView.hidden)return;
        [_emptyView setHidden:NO];
        if(self.separatorStyle != UITableViewCellSeparatorStyleNone)
        {
            _oldSepStyle = self.separatorStyle;
            self.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
    }
    else
    {
        if(_emptyView.hidden)return;
        [_emptyView setHidden:YES];
        if(_oldSepStyle != UITableViewCellSeparatorStyleNone)
        {
            self.separatorStyle = _oldSepStyle;
        }
    }
}

- (void)showFailureView:(BOOL)status_
{
    if(_failureView == nil)return;
    if(status_)
    {
        [_failureView setHidden:NO];
        if(self.separatorStyle != UITableViewCellSeparatorStyleNone)
        {
            _oldSepStyle = self.separatorStyle;
            self.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
    }
    else
    {
        [_failureView setHidden:YES];
        if(_oldSepStyle != UITableViewCellSeparatorStyleNone)
        {
            self.separatorStyle = _oldSepStyle;
        }
    }
}

#pragma mark - event
- (void)onEmptyViewTap:(UIGestureRecognizer*)tap_
{
    if(_errorViewClickEvent != nil)
    {
        _errorViewClickEvent(self, UV_TABLEVIEW_TYPE_EMPTY);
    }
}

- (void)onFailureViewTap:(UIGestureRecognizer*)tap_
{
    if(_errorViewClickEvent != nil)
    {
        _errorViewClickEvent(self, UV_TABLEVIEW_TYPE_FAILUREVIEW);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
