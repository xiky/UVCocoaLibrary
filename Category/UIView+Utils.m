//
//  UIView+Utils.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 9/29/13.
//  Copyright (c) 2013 XXXX. All rights reserved.
//

#import "UIView+Utils.h"
#import <objc/runtime.h>

static char kActionHandlerTapGestureKey;
static char kActionHandlerTapBlockKey;

@implementation UIView (Utils)

-(void)removeAllSubView
{
    for(UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
}

- (UITapGestureRecognizer*)addClickWithBlock:(void (^)(void))block
{
    self.userInteractionEnabled = YES;
	UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
	
	if (!gesture)
    {
		gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
		[self addGestureRecognizer:gesture];
		objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
	}
    
	objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
    return gesture;
}

- (UITapGestureRecognizer*)addClickWithSel:(id)target_ sel:(SEL)sel_
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:target_ action:sel_];
    [self addGestureRecognizer:gesture];
    objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    return gesture;
}

- (void)removeClickWithBlockAndSel
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if(!gesture)
    {
        [self removeGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, NULL, OBJC_ASSOCIATION_RETAIN);
    }
    id block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
    if(!block)
    {
        objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, NULL, OBJC_ASSOCIATION_COPY);
    }
}
- (void)handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
	if (gesture.state == UIGestureRecognizerStateRecognized)
    {
		void(^action)(void) = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
		
		if (action)
        {
			action();
		}
	}
}
- (void)setBackgroundImage:(UIImage *)image_
{
    UIImageView *view = [[UIImageView alloc] initWithImage:image_];
    view.frame = CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height);
    [self addSubview:view];
    [self sendSubviewToBack:view];
}

- (UIView *)showBadgeValue:(NSString *)strBadgeValue
{
    UITabBar *tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"" image:nil tag:0];
    item.badgeValue = strBadgeValue;
    NSArray *array = [[NSArray alloc] initWithObjects:item, nil];
    tabBar.items = array;

    //寻找
    for (UIView *viewTab in tabBar.subviews) {
        for (UIView *subview in viewTab.subviews) {
            NSString *strClassName = [NSString stringWithUTF8String:object_getClassName(subview)];
            if ([strClassName isEqualToString:@"UITabBarButtonBadge"] ||
                [strClassName isEqualToString:@"_UIBadgeView"]) {
                //从原视图上移除
                [subview removeFromSuperview];
                //
                [self addSubview:subview];
                subview.frame = CGRectMake(self.frame.size.width-subview.frame.size.width/2, -subview.frame.size.height/2,
                                           subview.frame.size.width, subview.frame.size.height);
                return subview;
            }
        }
    }
    return nil;
}

- (void)removeBadgeValue
{
    //
    for (UIView *subview in self.subviews) {
        NSString *strClassName = [NSString stringWithUTF8String:object_getClassName(subview)];
        if ([strClassName isEqualToString:@"UITabBarButtonBadge"] ||
            [strClassName isEqualToString:@"_UIBadgeView"]) {
            [subview removeFromSuperview];
            break;
        }
    }
}
@end
