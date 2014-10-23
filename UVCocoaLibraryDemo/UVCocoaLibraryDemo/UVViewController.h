//
//  UVViewController.h
//  UVCocoaLibraryDemo
//
//  Created by chenjiaxin on 14-5-15.
//  Copyright (c) 2014年 XXXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UVMenuButton;
@interface UVViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *text;
@property (weak, nonatomic) IBOutlet UVMenuButton *btnMenu;

- (IBAction)onClickSender:(id)sender;
@end
