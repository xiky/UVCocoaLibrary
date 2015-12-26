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
- (void)initData
{
    _autoShowEmptyView = YES;
    _isLoading = NO;
    _isFailured = NO;
}
#pragma mark - rewrite
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        [self initData];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self initData];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if(self = [super initWithFrame:frame style:style])
    {
        [self initData];
    }
    return self;
}
- (void)reloadData
{
    [super reloadData];
    //不是自动显示空视图 或 当前已经标识加载失败了，则不处理
    if(!_autoShowEmptyView || _isFailured)return;

    BOOL empty = [self emptyDataByTableview];
    [self showEmptyView:empty];
}

#pragma mark - public
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
    //加载中 不显示空视图
    if(_emptyView == nil)return;
    if(status_)
    {
        [self showFailureView:NO];
        //已经显示则不处理
        if(_emptyView.hidden == NO)return;
        [_emptyView setHidden:NO];
        if(self.separatorStyle != UITableViewCellSeparatorStyleNone)
        {
            _oldSepStyle = self.separatorStyle;
            self.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        [self scrollsToTop];
    }
    else
    {
        if(_emptyView.hidden == YES)return;
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
        [self showEmptyView:NO];
        if(_failureView.hidden == NO)return;
        
        [_failureView setHidden:NO];
        if(self.separatorStyle != UITableViewCellSeparatorStyleNone)
        {
            _oldSepStyle = self.separatorStyle;
            self.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        [self scrollsToTop];
    }
    else
    {
        if(_failureView.hidden == YES)return;
        [_failureView setHidden:YES];
        if(_oldSepStyle != UITableViewCellSeparatorStyleNone)
        {
            self.separatorStyle = _oldSepStyle;
        }
    }
}

- (void)setIsLoading:(BOOL)isLoading_
{
    if(_isLoading == isLoading_)return;
    _isLoading = isLoading_;
    //加载中，则不显示空视图
    if(_isLoading)
    {
        [self showEmptyView:NO];
    }
    
}
- (void)setIsFailured:(BOOL)isError_
{
    if(_isFailured == isError_)return;
    _isFailured = isError_;
    if(isError_)
    {
        BOOL empty = [self emptyDataByTableview];
        if(empty)
        {
            [self showFailureView:YES];
        }
    }
    else
    {
        [self showFailureView:NO];
    }
    
}

#pragma mark - private
/**
 *  检测当前tableview的数据源是否为空记录  满足section为1，且row为空
 *
 *  @return BOOL
 */
- (BOOL)emptyDataByTableview
{
    NSInteger sections = 1;
    if([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)])
    {
        sections = [self.dataSource numberOfSectionsInTableView:self];
    }
    NSInteger row = 0;
    if(sections > 0)
    {
        if([self.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)])
        {
            row = [self.dataSource tableView:self numberOfRowsInSection:0];
        }
    }

    if(sections <= 1 && row == 0)
    {
        return YES;
    }
    else
    {
        return NO;
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
