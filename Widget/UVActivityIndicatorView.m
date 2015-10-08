//  Copyright (c) 2014年 XXXX. All rights reserved.
// --------------------------------------------------------------------------------
// UVActivityIndicatorView.m
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

#import "UVActivityIndicatorView.h"

@implementation UVActivityIndicatorView
#pragma mark - init
- (void)initialize
{

}
- (id)init
{
    self = [super init];
    if (self)
    {
        [self initialize];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        [self initialize];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initialize];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
#pragma mark - public
- (void)setProgress:(CGFloat)progress_
{
    if(progress_<0.0 || progress_>1.0)
    {
        NSLog(@"setProgress failed,progress value:%.2f",progress_);
        return;
    }
    //如果label没有创建，则自动创建
    if(!_labelText)
    {
        CGRect frame = CGRectMake(0.f, 0.f, 20.f, 20.f);
        UIFont *font=[UIFont systemFontOfSize:8.f];;
        //self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//        switch(self.activityIndicatorViewStyle)
//        {
//            case UIActivityIndicatorViewStyleWhiteLarge:
//                frame = CGRectMake(0.f,0.f, 18.f, 18.f);
//                font = [UIFont systemFontOfSize:10.f];
//                break;
//            case UIActivityIndicatorViewStyleGray:
//                frame = CGRectMake(0.f, 0.f, 18.f, 18.f);
//                font = [UIFont systemFontOfSize:8.f];
//                break;
//            case UIActivityIndicatorViewStyleWhite:
//                frame = CGRectMake(0.f, 0.f, 18.f, 18.f);
//                font = [UIFont systemFontOfSize:8.f];
//                break;
//        }
        _labelText = [[UILabel alloc] initWithFrame:frame];
        _labelText.backgroundColor = [UIColor clearColor];
        _labelText.font = font;
        _labelText.textColor = [UIColor whiteColor];
        _labelText.textAlignment = NSTextAlignmentCenter;
        _labelText.autoresizingMask = UIViewAutoresizingNone;
        _labelText.clipsToBounds = YES;
        _labelText.contentMode = UIViewContentModeCenter;
        _labelText.center =CGPointMake(self.frame.size.width/2.f, self.frame.size.height/2.f);
        NSLog(@"lable frame:%@,view:%@",NSStringFromCGRect(frame),NSStringFromCGRect(self.frame));
        [self addSubview:_labelText];
    }
    NSInteger v = progress_ * 100;
    _labelText.text = [NSString stringWithFormat:@"%d",(int)v];
}
#pragma mark - private

#pragma mark - delegate

#pragma mark - trigger

#pragma mark - event
@end
