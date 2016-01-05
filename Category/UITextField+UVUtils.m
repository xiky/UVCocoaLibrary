//
//  UITextField+shadow.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 14-5-16.
//  Copyright (c) 2014年 XXXX. All rights reserved.
//

#import "UITextField+UVUtils.h"
#import <QuartzCore/QuartzCore.h>

@implementation UITextField (UVUtils)

- (void)uv_addCursorBorder:(UIColor*)color
{
    if(!color)
    {
        color = [UIColor lightGrayColor];
    }

//    
//    //self.background =
//  //  self.borderStyle = UITextBorderStyleBezel;
//    
    //边框
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = color.CGColor;

    //圆角
    self.layer.cornerRadius = 3.f;
    self.layer.masksToBounds = YES;
//
//    CAShapeLayer *layer = [CAShapeLayer layer];
//    CGRect frame = self.frame;
//    frame.origin.x = 0.f;
//    frame.origin.y = 0.f;
//    layer.fillColor = [UIColor redColor].CGColor;
//    //layer.lineCap = kCALineCapRound;
//    layer.bounds = frame;
//    
//    [self.layer addSublayer:layer];
    
//
//    //阴影
//    self.layer.shadowColor = [[UIColor redColor] CGColor];
//    self.layer.shadowOffset = CGSizeMake(10.0f, 10.0f); //[水平偏移, 垂直偏移]

}

- (void)uv_applyCustomBackground:(UIImage*)image_;
{
    if(!image_)
    {
        image_ = [UIImage imageNamed:@"operationbox_text"];
    }
    image_ = [image_ stretchableImageWithLeftCapWidth:image_.size.width * 0.5 topCapHeight:image_.size.height * 0.5];
    self.background = image_;
}
@end
