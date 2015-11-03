//
//  UIView+Utils.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 9/29/13.
//  Copyright (c) 2013 XXXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utils)

/**
 * 删除所有子视图
 */
-(void)uv_removeAllSubView;
/**
 * 使用Block向视图添加点击事件 
 *
 * 注：目前只支持顶多只能添加一个点击事件 重复添加会覆盖原来的事件
 * 
 * @param BLOCK 视图点击后执行的代码
 * @return UITapGestureRecognizer
 */
- (UITapGestureRecognizer*)addClickWithBlock:(void (^)(void))block;

/**
 * 向视图添加点击事件
 *
 * 注：目前只支持顶多只能添加一个点击事件 重复添加会覆盖原来的事件
 *
 * @param id target_
 * @param SEL 视图点击后执行的代码
 * @return UITapGestureRecognizer
 */
- (UITapGestureRecognizer*)addClickWithSel:(id)target_ sel:(SEL)sel_;

/**
 * 移除添加的点击事件
 *
 */
- (void)uv_removeClickWithBlockAndSel;


/**
 *  显示一个类型Tab的Badge值
 *
 *  @param strBadgeValue 要显示的值
 *
 *  @return Badge对象
 */
- (UIView *)uv_showBadgeValue:(NSString *)strBadgeValue;


/**
 *  设置视图圆角
 *
 *  @param radius_ 圆角大小
 */
- (void)uv_makeCornerRadius:(CGFloat)radius_;

/**
 *  给View增加虚线
 *
 *  @param color_ 虚线颜色 默认为 #666666
 *  @param dash_  虚线宽度和间隔 为数字数组 默认为 @[@4, @2]
 */
- (void)uv_strokeWithColor:(UIColor*)color_ lineDashPattern:(NSArray *)dash_;

@end
