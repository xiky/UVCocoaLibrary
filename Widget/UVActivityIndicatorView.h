//  Copyright (c) 2014年 XXXX. All rights reserved.
// --------------------------------------------------------------------------------
// UVActivityIndicatorView.h
//
// Project Code: UVCocoaLibrary
// Module Name:
// Date Created: 14-6-3
// Author: chenjiaxin/00891
// Description:
//
// --------------------------------------------------------------------------------
// Modification History
// DATE        NAME             DESCRIPTION
// --------------------------------------------------------------------------------
// 14-6-3  c0891 create
//

#import <UIKit/UIKit.h>

@interface UVActivityIndicatorView : UIActivityIndicatorView

@property(nonatomic,strong,readonly) UILabel *labelText;

/**
 *  在UVActivityIndicatorView增加一个UILabel，并显示当前的进度
 *
 *  @param progress_ 要显示的进度 范围为0.0-0.1
 */
- (void)setProgress:(CGFloat)progress_;

@end
