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
-(void)removeAllSubView;
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
- (void)removeClickWithBlockAndSel;
/**
 * 设置当前视图的背景图片 注：不能重复设置
 * @param UIImage image_ 要设置的图片
 */
- (void)setBackgroundImage:(UIImage *)image_;

/**
 *  显示一个类型Tab的Badge值
 *
 *  @param strBadgeValue 要显示的值
 *
 *  @return Badge对象
 */
- (UIView *)showBadgeValue:(NSString *)strBadgeValue;


//设置视图圆角
- (void)makeCornerRadius:(CGFloat)radius_;

@end
