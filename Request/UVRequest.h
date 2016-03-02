//  Copyright (c) 2014年 Zhejiang XXXX Technologies Co., Ltd. All rights reserved.
// --------------------------------------------------------------------------------
// UVRequest.h
//
// Project Code: UVCocoaLibrary
// Module Name:
// Date Created: 14-2-14
// Author: chenjiaxin/00891
// Description:
//
// --------------------------------------------------------------------------------
// Modification History
// DATE        NAME             DESCRIPTION
// --------------------------------------------------------------------------------
// 14-2-14  c00891 create
//
#import <UIKit/UIKit.h>
typedef void (^startProgress)(NSError *error);

@class UVError,MBProgressHUD;

/** 发送异常请求封装
    主要用于耗时的操作
 */
@interface UVRequest : NSObject
/**
 *  设置错误友好处理 Exception类型
 */
@property (nonatomic) UVError *errorException;
/**
 *  设置错误友好处理 NSError类型
 */
@property (nonatomic) UVError *errorNSError;
@property(nonatomic,readonly) dispatch_queue_t requestQueue;

- (id)init;

/** 实例化对象
 
 建议在使用前，均调用此静态方法
 
 @return UVRequest
 */
+(UVRequest*)instance;

//- (void)progress:(void (^)(UIView *view_, NSString *message_))start_ end:(void (^)())end_;


/** 发送异步请求
 
 @param block 耗时的代码块
 @param block 请求结束后执行的代码块 如果没有错误产生，error的值为nil，否则error保存UVError类型的错误信息
 */
- (void)exec:(void (^)())block_ finish:(void (^)(UVError *error))finish_;

/** 发送异步请求
 
 @param block 耗时的代码块
 @param block 请求结束后执行的代码块 如果没有错误产生，error的值为nil，否则error保存UVError类型的错误信息 注意：默认情况下，如果产生错误会自动提示错误信息，因此不需要额外对UVError进行处理。只需要判断一个UVError是否为nil，如果不是nil，表示有错误，直接return即可
 @param UIView 要显示加载条的视图
 */
- (void)exec:(void (^)())block_ finish:(void (^)(UVError *error))finish_ showProgressInView:(UIView*)view;

/** 发送异步请求
 
 @param block 耗时的代码块
 @param block 请求结束后执行的代码块 如果没有错误产生，error的值为nil，否则error保存UVError类型的错误信息
 @param UIView 要显示加载条的视图
 @param NSString 定制加载的提示信息
 */
- (void)exec:(void (^)())block_ finish:(void (^)(UVError *error))finish_ showProgressInView:(UIView*)view message:(NSString*)message;

/** 发送异步请求
 
 @param block 耗时的代码块
 @param block 请求结束后执行的代码块 如果没有错误产生，error的值为nil，否则error保存UVError类型的错误信息
 @param UIView 要显示加载条的视图 默认为nil 如果为nil，则不会显示加载条
 @param NSString 加载的提示信息 默认为loading
 @param BOOL 加载失败是否自动显示提示信息 默认为YES
 */
- (void)exec:(void (^)())block_ finish:(void (^)(UVError *error))finish_ showProgressInView:(UIView*)view message:(NSString*)message showToast:(BOOL)showToast_;

/** 显示进度条 
 该方法会在内容自动调用，如果想要自定义进度条，请覆盖此方法
 
 @param UIView 进度条遮盖的视图
 @param NSString 提示信息
 @return 返回一个进度条对象
 */
- (MBProgressHUD*)showProgress:(UIView*)view message:(NSString*)message;

/** 隐藏进度条
 */
- (void)hideProgress:(MBProgressHUD*)hud_;

- (void)releaseQueue;
@end
