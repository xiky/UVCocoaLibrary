//
//  UVCollectionView.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/12/30.
//  Copyright © 2015年 Uniview. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UVCollectionView;

typedef NS_ENUM(NSInteger, UV_COLLECTION_VIEW_STATUS) {
    UV_COLLECTION_VIEW_STATUS_IDLE,
    UV_COLLECTION_VIEW_STATUS_LOADING,
    UV_COLLECTION_VIEW_STATUS_EMPTY,
    UV_COLLECTION_VIEW_STATUS_FAILURED,
    UV_COLLECTION_VIEW_STATUS_FINISH
};
/**
 *  视图点击事件回调
 *
 *  @param tableView UVtableview
 *  @param status      UV_TABLEVIEW_STATUS
 */
typedef void (^statusViewClickListener)(UVCollectionView *tableView, UV_COLLECTION_VIEW_STATUS status);

@interface UVCollectionView : UICollectionView


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
@property (nonatomic,assign) UV_COLLECTION_VIEW_STATUS status;
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
