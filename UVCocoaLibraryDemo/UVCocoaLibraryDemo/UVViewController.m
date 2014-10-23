//
//  UVViewController.m
//  UVCocoaLibraryDemo
//
//  Created by chenjiaxin on 14-5-15.
//  Copyright (c) 2014年 XXXX. All rights reserved.
//

#import "UVViewController.h"
#import "UVLog.h"
#import "UVError.h"
#import "UVMenuButton.h"
#import "UIView+Shake.h"
#import "UITextField+shadow.h"
#import "UIViewController+Utils.h"

@interface UVViewController ()<UVMenuItemDelegate>

@end

@implementation UVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UVLog(@"test");
    UVError *error = [UVError errorWithCodeAndMessage:1 message:@"estseterror"];
    UVLog(@"test error:%@",error);
    
    [_btnMenu setMenuItems:@[@"测试一",@"测试二",@"测试三"]];
    _btnMenu.delegate = self;
    [_text applyCustomBackground:nil];
    [self addTapHideKeyBroard];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickSender:(id)sender
{
    UIView *btn = (UIView*)sender;
    [btn shake:5 withDelta:2.f];
}


- (void)onMenuItemClick:(UVMenuButton*)sender_ index:(NSInteger)index_ text:(NSString*)text_
{
    UVLog(@"index:%d,text:%@",index_,text_);
}
@end
