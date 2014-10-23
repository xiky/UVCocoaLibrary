//
//  UVMenuButton.h
//  MenuController
//
//  Created by chenjiaxin on 14-5-19.
//  Copyright (c) 2014年 XXXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UVMenuItemDelegate;

/**
 *  在按钮上打开一个 菜单
 *  使用方法：
        [button setMenuItems:@[@"测试一",@"测试二",@"测试三"]]; 
 
 *  同样的原理，可以在任意UIView上实现这个功能，在这个类里面，事件触发入口是：initData里面的:
        [self addTarget:self action:@selector(onClickSender:) forControlEvents:UIControlEventTouchUpInside];
*  如果是其它的视图，把这里的代码替换为相当的触发事件代码即可 如UITapGestureRecognizer
 
 附：UIMenuController弹出必须条件：
 1. Menu所处的View必须实现 – (BOOL)canBecomeFirstResponder, 且返回YES
 2. Menu所处的View必须实现 – (BOOL)canPerformAction:withSender, 并根据需求返回YES或NO
 3. 使Menu所处的View成为First Responder (becomeFirstResponder)
 4. 定位Menu (- setTargetRect:inView:)
 5. 展示Menu (- setMenuVisible:animated:)
 */
@interface UVMenuButton : UIButton
@property(nonatomic,weak) id<UVMenuItemDelegate> delegate;
/**
 *  要设置的菜单项
 */
@property(nonatomic,strong) NSArray* menuItems;
@end

/**
 *  菜单项点击协议
 */
@protocol UVMenuItemDelegate <NSObject>
- (void)onMenuItemClick:(UVMenuButton*)sender_ index:(NSInteger)index_ text:(NSString*)text_;
@end
