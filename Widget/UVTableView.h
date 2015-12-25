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
