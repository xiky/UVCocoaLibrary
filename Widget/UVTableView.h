//
//  UVTableView.h
//  testTableview
//
//  Created by chenjiaxin on 15/12/23.
//  Copyright © 2015年 chenjaixin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UVTableView;

typedef NS_ENUM(NSInteger, UV_TABLEVIEW_TYPE) {
    UV_TABLEVIEW_TYPE_EMPTY = 1,
    UV_TABLEVIEW_TYPE_FAILUREVIEW
};

/**
 *  视图点击事件回调
 *
 *  @param tableView UVtableview
 *  @param type      UV_TABLEVIEW_TYPE
 */
typedef void (^errorViewClickListener)(UVTableView *tableView, UV_TABLEVIEW_TYPE type);


@interface UVTableView : UITableView

/**
 *  数据为空视图
 */
@property (nonatomic,strong) UIView *emptyView;
/**
 *  数据加载失败视图
 */
@property (nonatomic,strong) UIView *failureView;
/**
 *  视图点击事件
 */
@property (nonatomic,strong) errorViewClickListener errorViewClickEvent;
/**
 *  标记是否在加载中 默认为NO  由用户自行控制。加载中状态不会显示空视图.
 */
@property (nonatomic,assign) BOOL isLoading;
/**
 *  标记当前加载失败了 默认为NO，由用户自行控制。设置这个状态为YES，当前tableview记录为空，则会显示失败视图
 */
@property (nonatomic,assign) BOOL isFailured;
/**
 *  是否自动检测显示空视图 默认为YES
 */
@property (nonatomic) BOOL autoShowEmptyView;

/**
 *  控制是否显示数据为空视图
 *
 *  @param status_ BOOL
 */
- (void)showEmptyView:(BOOL)status_;
/**
 *  控制是否显示错误视图
 *
 *  @param status_ BOOL
 */
- (void)showFailureView:(BOOL)status_;
@end
