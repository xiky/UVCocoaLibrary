//
//  UVTableView.h
//  testTableview
//
//  Created by chenjiaxin on 15/12/23.
//  Copyright © 2015年 chenjaixin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UVTableView;
/**
 *  UItablewView当前状态
 */
typedef NS_ENUM(NSInteger, UV_TABLEVIEW_STATUS) {
    /**
     *  空闲
     */
    UV_TABLEVIEW_STATUS_IDLE,
    /**
     *  加载中
     */
    UV_TABLEVIEW_STATUS_LOADING,
    /**
     *  加载完成，数据为空
     */
    UV_TABLEVIEW_STATUS_EMPTY,
    /**
     *  加载出错
     */
    UV_TABLEVIEW_STATUS_FAILURED,
    /**
     *  加载完成，且有数据
     */
    UV_TABLEVIEW_STATUS_FINISH
};

/**
 *  视图点击事件回调
 *
 *  @param tableView UVtableview
 *  @param status      UV_TABLEVIEW_STATUS
 */
typedef void (^statusViewClickListener)(UVTableView *tableView, UV_TABLEVIEW_STATUS status);

/**
 *  自定义一个uitablewview，增加一个居中视图。视图中放置一个UIImageView,两个UILable。主要用于uitableview状态显示
 */
@interface UVTableView : UITableView
/**
 *  图片
 */
@property (nonatomic,readonly) UIImageView *imageviewStatus;
/**
 *  状态标题
 */
@property (nonatomic,readonly) UILabel *lblStatus;
/**
 *  状态内容
 */
@property (nonatomic,readonly) UILabel *lblStatusDetail;
/**
 *  状态视图 如加载、空视图、错误视图等  默认会增加一个图片视图 2个文本视图
 */
@property (nonatomic,strong,readonly) UIView *statusView;

/**
 *  头部间距 默认为130.f
 */
@property (nonatomic) CGFloat topMargin;


/**
 *  视图点击事件
 */
@property (nonatomic,strong) statusViewClickListener errorViewClickEvent;
/**
 *  标记状态  由用户自行控制
 */
@property (nonatomic,assign) UV_TABLEVIEW_STATUS status;
/**
 *  控制是否显示状态视图
 *
 *  @param status_ BOOL
 */
- (void)showStatusView:(BOOL)show_;

/**
 *  检测当前tableview的数据源是否为空记录  满足section为1，且row为空
 *
 *  @return BOOL
 */
- (BOOL)emptyDataByTableview;
@end
