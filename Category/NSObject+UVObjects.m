//
//  NSObject+UVObjects.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 13-8-29.
//  Copyright (c) 2013年 XXXX. All rights reserved.
//

#import "NSObject+UVObjects.h"
#import "MBProgressHUD.h"
#import "iToast.h"
#import "UVError.h"

@implementation NSObject (UVObjects)

- (void)iToastMessage:(NSString*)message
{
    [[[[iToast makeText:message] setGravity:iToastGravityBottom] setDuration:2000] show];
}
- (void)showError:(UVError*)error_
{
    if(error_ == nil)return;
    NSString *mess = [NSString stringWithFormat:@"%@,错误码:%d",error_.message,error_.code];
    [self iToastMessage:mess];
    mess = nil;
}
-(MBProgressHUD*)progress:(UIView *)view_ message:(NSString *)mess_
{
    if(!view_)
    {
        return nil;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view_ animated:YES];
    
	hud.mode = MBProgressHUDModeText;
	hud.labelText = mess_;
    
	hud.removeFromSuperViewOnHide = YES;
    return hud;
}
@end
