//  Copyright (c) 2014年 Zhejiang XXXX Technologies Co., Ltd. All rights reserved.
// --------------------------------------------------------------------------------
// UVRequest.m
//
// Project Code: UVCocoaLibrary
// Module Name:
// Date Created: 14-2-14
// Author: chenjiaxin/00891
// Description:
//
// --------------------------------------------------------------------------------
// Modification History
// DATE        NAME             DESCRIPTION
// --------------------------------------------------------------------------------
// 14-2-14  c00891 create
//

#import "UVRequest.h"

#import "MBProgressHUD.h"

#import "iToast.h"
#import "UVError.h"
#import "UIView+Toast.h"

static UVRequest *_requestinstance = nil;
@implementation UVRequest
{
}
- (void)initData
{
    //_requestQueue = dispatch_queue_create("_requestQueue", DISPATCH_QUEUE_SERIAL);
    _requestQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

- (id)init
{
    if(self = [super init])
    {
        [self initData];
    }
    return self;
}
+(UVRequest*)instance
{
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        _requestinstance = [[UVRequest alloc] init];
    });
    return _requestinstance;
}
- (void)exec:(void (^)())block_ finish:(void (^)(UVError *error))finish_
{
    [self exec:block_ finish:finish_ showProgressInView:nil message:nil showToast:YES];
}
- (void)exec:(void (^)())block_ finish:(void (^)(UVError *error))finish_ showProgressInView:(UIView*)view
{
    [self exec:block_ finish:finish_ showProgressInView:view message:nil showToast:YES];
}
- (void)exec:(void (^)())block_ finish:(void (^)(UVError *error))finish_ showProgressInView:(UIView*)view message:(NSString*)message
{
    [self exec:block_ finish:finish_ showProgressInView:view message:message showToast:YES];
}
- (void)exec:(void (^)())block_ finish:(void (^)(UVError *error))finish_ showProgressInView:(UIView*)view message:(NSString*)message showToast:(BOOL)showToast_
{
    if(message == nil && view != nil)
    {
        message = nil;
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    __weak UVRequest *Self = self;
    dispatch_async(_requestQueue, ^{@autoreleasepool {
        UVError *err = nil;
        __block MBProgressHUD* hub = nil;
        if(view != nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                hub = [Self showProgress:view message:message];
            });
        }
        @try {
            block_();
        }
        @catch (UVError *exception) {
            err = exception;
        }
        @catch (NSException *exception) {
            err = [UVError errorWithCodeAndMessage:UV_GENERAL_ERROR_CODE message:exception.reason];
            err.orginalException = exception;
        }
        @catch (NSError *error) {
            err = [UVError errorWithCodeAndMessage:error.code message:error.localizedDescription];
            err.orginalError = error;
        }
        @finally {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(hub != nil)
                {
                    [Self hideProgress:hub];
                    hub = nil;
                }
                if(finish_ != nil)
                {
                    finish_(err);
                }
                if(showToast_ && err != nil)
                {
                    [Self showError:err inview:view];
                }
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            });
        }
    }});
}
- (void)releaseQueue
{
    if(_requestQueue!=nil)
    {
        //dispatch_release(_requestQueue);
        _requestQueue = nil;
    }
}
- (void)showError:(UVError*)error_ inview:(UIView*)view_
{
    if(error_ == nil || view_ == nil)return;
    NSString *mess = [NSString stringWithFormat:@"%@",error_.message];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view_];
    hud.color = [UIColor colorWithRed:77.0f/255.0f green:185.0/255.0f blue:237.0/255.0f alpha:0.8f];
    [view_ addSubview:hud];

    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hub_icon_error"]];
    
    // Set custom view mode
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.detailsLabelText = mess;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [hud hide:YES afterDelay:2];
    
    
//    NSString *mess = [NSString stringWithFormat:@"%@,错误码:%ld",error_.message, (long)error_.code];
    
    
//    [view_ makeToast:mess duration:2 position:CSToastPositionTop];
//    [[[[iToast makeText:mess] setGravity:iToastGravityBottom] setDuration:2000] show];
//    mess = nil;
}
- (MBProgressHUD*)showProgress:(UIView*)view_ message:(NSString*)mess_
{
    if(!view_)
    {
        return nil;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view_ animated:YES];
    hud.color = [UIColor colorWithRed:77.0f/255.0f green:185.0/255.0f blue:237.0/255.0f alpha:.8f];
    hud.animationType = MBProgressHUDAnimationFade;
	hud.mode = MBProgressHUDModeIndeterminate;
	hud.labelText = mess_;
    
	hud.removeFromSuperViewOnHide = YES;
    return  hud;
}
- (void)hideProgress:(MBProgressHUD*)hud_
{
    MBProgressHUD *hud = (MBProgressHUD*)hud_;
    [hud hide:YES];
}
@end
