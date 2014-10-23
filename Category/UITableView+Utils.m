//
//  UITableView+Utils.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 10/23/13.
//  Copyright (c) 2013 XXXX.com. All rights reserved.
//

#import "UITableView+Utils.h"

@implementation UITableView (Utils)
- (void)setExtraCellLineHidden
{
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
    [self setTableHeaderView:view];
}
@end
