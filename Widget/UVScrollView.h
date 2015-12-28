//
//  UVScrollView.h
//  UVCocoaLibrary
//
//  Created by ios on 15/9/30.
//  Copyright © 2015年 chenjiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UVScrollViewPageDelegate;

@interface UVScrollView : UIScrollView
@property (nonatomic,weak) id<UVScrollViewPageDelegate> pageDelegate;
/**
 *  设置响应触摸子视图数组
 */
@property (nonatomic,strong) NSArray *touchviews;

/**
 *  视图控制数组
 */
@property (nonatomic,readonly) NSArray *viewControllers;

/**
 *  设置视图控制器数组
 *
 *  @param viewControllers_ 视图控制器列表
 *  @param size_            显示的区域大小  不同的视图控制器要保持一致
 */
- (void)setViewControllers:(NSArray *)viewControllers_ size:(CGSize)size_;
@end

@protocol UVScrollViewPageDelegate <NSObject>

@optional
- (void)onScrollViewPageChange:(UVScrollView*)view page:(NSInteger)page_;
@end
