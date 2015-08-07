//
//  UINavigationController+Utils.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/8/6.
//  Copyright (c) 2015年 Uniview. All rights reserved.
//

#import "UINavigationController+Utils.h"
#import "NSObject+UVObjects.h"

@implementation UINavigationController (Utils)


- (void)pushViewControllerByStoryboard:(NSString*)storyboard_ viewControllerIdentifier:(NSString*)identifier_
{
    UIViewController *view = [self viewControllerWithStoryboard:storyboard_ identifier:identifier_];
    [self pushViewController:view animated:YES];
}
@end
