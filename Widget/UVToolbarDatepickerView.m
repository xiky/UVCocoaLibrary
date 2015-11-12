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
}

- (void)initData
{
    UIView *view = self;
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.f, 0.f, _parentview.frame.size.width, 44.f)];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onCancel:)];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(onSure:)];
    
    [bar setItems:@[left,flex,right]];
    
    [view addSubview:bar];
    
    UIDatePicker *datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0.0,44.f,view.frame.size.width,0.0)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.minuteInterval = 5;
    [view addSubview:datePicker];
}

- (id)initWithParentView:(UIView*)view_;
{
    if(self = [super init])
    {
        _parentview = view_;
        self.frame = CGRectMake(0.f, _parentview.frame.size.height, _parentview.frame.size.width, 44.f+216.f);
        [self initData];
    }
    return self;
}
/**
 *  从底向上显示
 */
- (void)show
{
    
}
/**
 *  隐藏
 */
- (void)hide
{
    
}
- (void)onCancel:(id)sender_
{
    
}

- (void)onSure:(id)sender_
{
    
}
@end
