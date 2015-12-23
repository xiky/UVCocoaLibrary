//
//  UIViewController+Utils.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 10/18/13.
//  Copyright (c) 2013 XXXX.com. All rights reserved.
//
#import "UIViewController+Utils.h"

@implementation UIViewController (Utils)


///**
// * 支持的设备方向
// */
////for ios5.0
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
//}
//
////for ios6.0
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//- (BOOL)shouldAutorotate
//{
//    return YES;
//}


#pragma mark - private


-(void)uv_addTapHideKeyBroard
{
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uv_viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
}

- (void)uv_setCustomLeftButtom:(UIBarButtonItem*)item_
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:self action:nil];
    negativeSpacer.width = -8.f;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,item_];
}

#pragma mark - private
-(void)uv_viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.view endEditing:YES];
}
@end
