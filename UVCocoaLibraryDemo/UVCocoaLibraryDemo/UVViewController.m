//
//  UVViewController.m
//  UVCocoaLibraryDemo
//
//  Created by chenjiaxin on 14-5-15.
//  Copyright (c) 2014年 XXXX. All rights reserved.
//

#import "UVViewController.h"
#import "UVLogger.h"
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
    //初始化日志服务器
    [[UVLogger instance] server:@"10.17.36.30"];
    [[UVLogger instance] setLevel:UVLOG_LEVEL_VERBOSE];
    
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

- (IBAction)onLogSender:(id)sender {
    UVLogV(@"UVLogV s:%@,i=%d",@"11212",2222);
    UVLogD(@"UVLogD s:%@,i=%d",@"11212",2222);
    UVLogI(@"UVLogI s:%@,i=%d",@"11212",2222);
    UVLogW(@"UVLogV s:%@,i=%d",@"11212",2222);
    UVLogE(@"UVLogE s:%@,i=%d",@"11212",2222);
    UVLogA(@"UVLogE s:%@,i=%d",@"11212",2222);
    UVLog(@"UVLog s:%@,i=%d",@"11212",2222);
    NSLog(@"NSLog s:%@,i=%d",@"11212",2222);
}

- (IBAction)onClickSender:(id)sender
{
    UIView *btn = (UIView*)sender;
    [btn shake:5 withDelta:2.f];
}

- (IBAction)onCaskSender:(id)sender {
    NSArray * a= @[@(0)];
    NSLog(@"%@",a[2]);
}


- (void)onMenuItemClick:(UVMenuButton*)sender_ index:(NSInteger)index_ text:(NSString*)text_
{
    UVLog(@"index:%ld,text:%@",index_,text_);
}
@end
