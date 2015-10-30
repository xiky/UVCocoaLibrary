//
//  YKModelView.h
//  YKActionSheet.h YKActionSheet
//
//  Created by chenjiaxin on 15/10/29.
//  Copyright © 2015年 chenjiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UVModelViewDelegate;

/**
 *  模态视图 简单实现从下往上弹出模态视图
 */
@interface UVModelView : UIView
@property (nonatomic,weak) id<UVModelViewDelegate> delegate;
/**
 *  当前子视图
 */
@property(nonatomic,strong,readonly) UIView *childView;
/**
 *  当前状态是否 已经显示
 */
@property(nonatomic,assign,readonly) BOOL isShow;
/**
 *  点击遮盖区域，是否自动隐藏 默认为YES
 */
@property(nonatomic,assign) BOOL autoHidden;
/**
 *  动画持续时间 默认为0.5f
 */
@property(nonatomic,assign) CGFloat animateDuration;

/**
 *  初始化
 *
 *  @param view_ 要显示的子视图
 *
 *  @return self
 */
- (id)initWithChildView:(UIView*)view_;
/**
 *  在指定视图中显示
 *
 *  @param view_ 父视图
 */
- (void)showInSupperView:(UIView*)view_;
/**
 *  隐藏
 */
- (void)hide;
@end

@protocol UVModelViewDelegate <NSObject>

@optional
/**
 *  隐藏时回调
 *
 *  @param view_ self
 */
- (void)onUVModelViewHide:(UVModelView*)view_;
@end
