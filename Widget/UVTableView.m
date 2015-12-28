//
//  UVTableView.m
//  testTableview
//
//  Created by chenjiaxin on 15/12/23.
//  Copyright © 2015年 chenjaixin. All rights reserved.
//

#import "UVTableView.h"
#import "UVDevice.h"

@interface UVTableView ()
/**
 *  保存原来的cell分隔线
 */
@property (nonatomic,assign) UITableViewCellSeparatorStyle oldSepStyle;
@end

@implementation UVTableView
- (void)initData
{
    _status = UV_TABLEVIEW_STATUS_IDLE;
    
    UVDevice *device = [UVDevice new];
    _statusView = [UIView new];
    
    _topMargin = 130.f * device.scaleHeight;
    
    _imageviewStatus = [[UIImageView alloc] init];
    [_statusView addSubview:_imageviewStatus];
    
    _lblStatus = [UILabel new];
    _lblStatus.textAlignment = NSTextAlignmentCenter;
    _lblStatus.textColor = [UIColor colorWithRed:153.0/255.0f green:153.0/255.0f blue:153.0/255.0f alpha:1.0f];
    _lblStatus.font = [UIFont systemFontOfSize:16.f];
    [_statusView addSubview:_lblStatus];
    
    _lblStatusDetail = [UILabel new];
    _lblStatusDetail.textAlignment = NSTextAlignmentCenter;
    _lblStatusDetail.textColor = [UIColor colorWithRed:153.0/255.0f green:153.0/255.0f blue:153.0/255.0f alpha:1.0f];
    _lblStatusDetail.font = [UIFont systemFontOfSize:14.0f];
    [_statusView addSubview:_lblStatusDetail];
    
    [self addSubview:_statusView];
    
    _statusView.userInteractionEnabled = YES;
    _statusView.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onStatusViewTap:)];
    [_statusView addGestureRecognizer:tap];
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
- (void)layoutSubviews
{
    [super layoutSubviews];
    

    [self updateFrame];
}

- (void)updateFrame
{
    UVDevice *device = [UVDevice new];
    CGSize imageSize = CGSizeMake(160.f * device.scaleHeight, 160.f * device.scaleHeight);
    if(_imageviewStatus.image != nil)
    {
        imageSize = CGSizeMake(_imageviewStatus.image.size.width * device.scaleHeight, _imageviewStatus.image.size.height * device.scaleHeight);
    }
    
    
    CGFloat viewWidth = self.frame.size.width;
    //当然图片的高度 + 20 间距 + 20 文本的高度 + 10间距 + 20详细文本高度
    CGFloat h = imageSize.height + 20.f + 20.f + 10.f + 20.f;
    CGFloat x = 0;
    CGFloat y = _topMargin;
    CGFloat w = viewWidth;
    
    CGRect frame = CGRectMake(x, y, w, h);
    self.statusView.frame = frame;
    
    w = imageSize.width;
    h = imageSize.height;
    x = (viewWidth - w) / 2.f;
    y = 0;
    frame = CGRectMake(x, y, w, h);
    _imageviewStatus.frame = frame;
    
    y = h + 20.f;
    w = viewWidth;
    h = 20.f;
    x = 0.f;
    frame = CGRectMake(x, y, w, h);
    _lblStatus.frame = frame;
    
    y = y + h + 10.f;
    frame = CGRectMake(x, y, w, h);
    _lblStatusDetail.frame = frame;
}

#pragma mark - public

- (void)showStatusView:(BOOL)status_
{
    //加载中 不显示空视图
    if(_statusView == nil)return;
    if(status_)
    {
        //已经显示则不处理
        if(_statusView.hidden == NO)return;
        [_statusView setHidden:NO];
        if(self.separatorStyle != UITableViewCellSeparatorStyleNone)
        {
            _oldSepStyle = self.separatorStyle;
            self.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
    }
    else
    {
        if(_statusView.hidden == YES)return;
        [_statusView setHidden:YES];
        if(_oldSepStyle != UITableViewCellSeparatorStyleNone)
        {
            self.separatorStyle = _oldSepStyle;
        }
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

- (void)onStatusViewTap:(UIGestureRecognizer*)tap_
{
    if(_errorViewClickEvent != nil)
    {
        _errorViewClickEvent(self, _status);
    }
}
@end
