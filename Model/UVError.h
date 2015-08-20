// Copyright (c) 2011-2014, Zhejiang XXXX Technologies Co., Ltd. All rights reserved.
// --------------------------------------------------------------------------------
// UVError.h
//
// Project Code: UVCocoaLibrary
// Module Name:
// Date Created: 2013-11-19
// Author: chenjiaxin/00891
// Description:错误封装类
//
// --------------------------------------------------------------------------------
// Modification History
// DATE        NAME             DESCRIPTION
// --------------------------------------------------------------------------------
//
/** 错误封装类
 
 错误产生后，通常通过这个类查看到相关的错误信息，示例代码：
 
        UVLog("error:%@",error);
 
 */
//定义库内部使用的错误码
#define UV_GENERAL_ERROR_CODE (-10101)
#define UV_ERROR_CODE_CANCEL (-10102)
#define UV_EROOR_CODE_UNKNOWN (-10103)

@interface UVError :NSObject
//错误码
@property(nonatomic,assign,readonly) NSInteger code;
//具体错误信息
@property(nonatomic,strong,readonly) NSString *message;
@property(nonatomic,assign) NSInteger errorType;

@property(nonatomic,strong) NSException *orginalException;
@property(nonatomic,strong) NSError *orginalError;


/** 根据错误码和错误信息实例化一个错误类
 
 @param NSInteger code_ 错误码 自已指定的任何整数错误码 建议不要和系统错误码冲突
 @param NSString msg_ 错误描述
 @return UVError 错误类
 */
+ (id)errorWithCodeAndMessage:(NSInteger)code_ message:(NSString*)msg_;

/**
 *  根据NSError返回一个UVError
 *
 *  @param error_ NSError
 *
 *  @return UVError
 */
+ (id)errorWithNSError:(NSError*)error_;
@end
