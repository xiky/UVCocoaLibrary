//  Copyright (c) 2014年 XXXX. All rights reserved.
// --------------------------------------------------------------------------------
// UVURLConnectionDataDelegate.h
//
// Project Code: HttpClient
// Module Name:
// Date Created: 14-2-27
// Author: chenjiaxin/00891
// Description:
//
// --------------------------------------------------------------------------------
// Modification History
// DATE        NAME             DESCRIPTION
// --------------------------------------------------------------------------------
// 14-2-27  c00891 create
//
#import "UVHttpClient.h"

@interface UVURLConnectionDataDelegate : NSObject

@property(nonatomic,weak) id<UVHttpClientDelegate> delegate;
@property(nonatomic,strong,readonly) NSMutableData *data;
@property(nonatomic,strong,readonly) NSError *error;
@property(nonatomic,strong,readonly) NSHTTPURLResponse *response;
@property(nonatomic,assign,readonly) REQUEST_STATUS status;
@property(nonatomic,strong,readonly) NSString *downFilePath;
@property(nonatomic,strong,readonly) finishDownListener finishDownBlock;
//http验证用户名
@property(nonatomic,strong) NSString *username;
//http验证密码
@property(nonatomic,strong) NSString *password;


- (id)initWithClient:(UVHttpClient*)client delegate:(id<UVHttpClientDelegate>)delegate_;
- (id)initWithDownClient:(UVHttpClient*)client_ delegate:(id<UVHttpClientDelegate>)delegate_ down:(NSString*)path_ finish:(finishDownListener)finish_;

///** 实例化对象
// 
// @return UVURLConnectionDataDelegate
// */
//+ (UVURLConnectionDataDelegate*)instance;
- (BOOL)isFinished;
@end
