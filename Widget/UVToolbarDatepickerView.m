//
//  UVToolbarDatepickerView.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/11/12.
//  Copyright © 2015年 Uniview. All rights reserved.
//

#import "UVToolbarDatepickerView.h"

@implementation UVToolbarDatepickerView
{
    UIView *_parentview;
    
    UIBarButtonItem *_left;
    UIBarButtonItem *_right;
}

- (void)initData
{
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.f, 0.f, _parentview.frame.size.width, 44.f)];
    
    _left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel:)];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    _right = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(onSure:)];
    
    [_toolbar setItems:@[_left,flex,_right]];
    
    [self addSubview:_toolbar];
    
    _datepicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0.0,44.f,_parentview.frame.size.width,0.0)];
    _datepicker.datePickerMode = UIDatePickerModeDate;
    _datepicker.minuteInterval = 5;
    
    [self addSubview:_datepicker];
    
    self.hidden = YES;
    self.frame = CGRectMake(0.f, _parentview.frame.size.height, _parentview.frame.size.width, 44.f+216.f);
    [_parentview addSubview:self];
    _isShow = NO;
    _animateDuration = 0.5f;
}

- (id)initWithParentView:(UIView*)view_;
{
    if(self = [super init])
    {
        _parentview = view_;
        
        [self initData];
    }
    return self;
}

- (void)setCancelText:(NSString *)cancelText_
{
    [_left setTitle:cancelText_];
}

- (void)setSureText:(NSString *)sureText_
{
    [_right setTitle:sureText_];
}
- (void)setSelectDate:(NSDate *)selectDate_
{
    _datepicker.date = selectDate_;
}
/**
 *  从底向上显示
 */
- (void)show
{
    if(_isShow)
    {
        return;
    }
    _isShow = YES;
    self.hidden = NO;
    [UIView animateWithDuration:_animateDuration animations:^{
        CGRect frame = self.frame;
        frame.origin.y = _parentview.frame.size.height - frame.size.height;
        self.frame = frame;
    }];
}
/**
 *  隐藏
 */
- (void)hide
{
    if(!_isShow)
    {
        return;
    }
    
    _isShow = NO;
    [UIView animateWithDuration:_animateDuration animations:^{
        CGRect frame = self.frame;
        frame.origin.y = _parentview.frame.size.height;
        self.frame = frame;
        
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}
- (void)onCancel:(id)sender_
{
    [self hide];
    [self triggerEvent:UV_TOOLBAR_DATEPICKER_CLICK_TYPE_CANCEL];
}

- (void)onSure:(id)sender_
{
    [self hide];
    [self triggerEvent:UV_TOOLBAR_DATEPICKER_CLICK_TYPE_SURE];
}

- (void)triggerEvent:(UV_TOOLBAR_DATEPICKER_CLICK_TYPE)type_
{
    
    if(_delegate && [_delegate respondsToSelector:@selector(onToolbarDatepickerViewChange:type:selectDate:)])
    {
        [_delegate onToolbarDatepickerViewChange:self type:type_ selectDate:_datepicker.date];
    }
}
@end
