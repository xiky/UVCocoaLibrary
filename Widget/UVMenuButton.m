//
//  UVMenuButton.m
//  MenuController
//
//  Created by chenjiaxin on 14-5-19.
//  Copyright (c) 2014年 XXXX. All rights reserved.
//

#import "UVMenuButton.h"
#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif
@interface UVMenuButton()
{
    
}
- (NSInteger)indexBySel:(SEL)sel_;
- (void)triggerMenuClick:(NSInteger)index_;

@end

/**
 *  菜单项点击统一触发入口
 *
 *  @param self 对象自身
 *  @param _cmd SEL
 */
void onMenuItemClick(id self, SEL _cmd)
{
    UVMenuButton *Self = (UVMenuButton*)self;
    NSInteger pos = [Self indexBySel:_cmd];
    [Self triggerMenuClick:pos];
}

@implementation UVMenuButton
{
    UIMenuController *_menu;
    NSArray *_items;
}
- (void)initData
{
    [self addTarget:self action:@selector(onClickSender:) forControlEvents:UIControlEventTouchUpInside];
}
- (id)init
{
    if(self = [super init])
    {
        [self initData];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        [self initData];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initData];
    }
    return self;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    //只显示自行添加的菜单
    NSInteger pos = [self indexBySel:action];
    return (pos == -1)?NO:YES;
}


- (void)setMenuItems:(NSArray *)menuItems
{
    if(!_menu)
    {
        _menu = [[UIMenuController alloc] init];
    }
  
    NSMutableArray *items = [[NSMutableArray alloc] init];
    UIMenuItem *menuitem;
    NSInteger i =0;
    NSString *text;
    NSString *method;
    
    _items = menuItems;
    SEL sel;
    for(i=0; i < menuItems.count; i++)
    {
        text = [menuItems objectAtIndex:i];
        //方法SEL
        method = [NSString stringWithFormat:@"itemclick%ld",(long)i];
        sel = NSSelectorFromString(method);
        //如果方法不存在
        if(! [self respondsToSelector:sel])
        {
            //动态在当前类添加一个方法 关键代码
            class_addMethod([self class], sel, (IMP)onMenuItemClick, "v@:");
        }
        //初始化一个菜单项
        menuitem = [[UIMenuItem alloc] initWithTitle:text action:sel];
        [items addObject:menuitem];
    }
    [_menu setMenuItems:items];
    [items removeAllObjects];
}

/**
 *  根据SEL对象获取当前点击的位置
 *
 *  @param sel_ 单击UIMenuItem的SEL
 *
 *  @return 找到的数组的索引
 */
- (NSInteger)indexBySel:(SEL)sel_
{
    NSString *method;
    SEL sel;
    for(NSInteger i=0;i<_items.count;i++)
    {
        method = [NSString stringWithFormat:@"itemclick%ld",(long)i];
        sel = NSSelectorFromString(method);
        if(sel_ == sel)
        {
            return i;
            break;
        }
    }
    return -1;
}

/**
 *  根据ID获取当前数组的名称
 *
 *  @param index_ 数组索引
 *
 *  @return 数组索引处的名称
 */
- (NSString*)stringByItemIndex:(NSInteger)index_
{
    if(index_<0 || index_>=_items.count)
    {
        return nil;
    }
    return _items[index_];
}

/**
 *  按钮单击事件处理，隐藏/显示UIMenuController
 *
 *  @param sender_ 单击的对象自身
 */
- (void)onClickSender:(id)sender_
{
    UIButton *button = (UIButton*)sender_;
    [button becomeFirstResponder];
    [_menu setTargetRect:button.frame inView:button.superview];
    [_menu setMenuVisible:!_menu.isMenuVisible animated:YES];
}

- (void)triggerMenuClick:(NSInteger)index_
{
    if(_delegate != nil && [_delegate respondsToSelector:@selector(onMenuItemClick:index:text:)])
    {
        [_delegate onMenuItemClick:self index:index_ text:[self stringByItemIndex:index_]];
    }
}
@end
