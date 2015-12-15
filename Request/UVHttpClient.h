//  Copyright (c) 2014年 XXXX. All rights reserved.
// --------------------------------------------------------------------------------
// UVHttpClient.h
//
// Project Code: UVCocoaLibrary
// Module Name:
// Date Created: 14-2-21
// Author: chenjiaxin/00891
// Description:
//
// --------------------------------------------------------------------------------
// Modification History
// DATE        NAME             DESCRIPTION
// --------------------------------------------------------------------------------
// 14-2-21  c00891 create
//
#import <UIKit/UIKit.h>
//请求参数键名
#define REQUEST_FIELD_NAME @"name"
//请求参数值名
#define REQUEST_FIELD_VALUE @"value"

//返回数据格式
typedef enum {
    RESPONSE_TYPE_BYTES=1,
    RESPONSE_TYPE_TEXT,
    RESPONSE_TYPE_JSON,
    RESPONSE_TYPE_XML,
    RESPONSE_TYPE_IMAGE
}RESPONSE_TYPE;

typedef enum {
    //正在发送请求
    REQUEST_STARTING,
    //服务器已得到响应
    REQUEST_RESPONSED,
    //正在接受数据
    REQUEST_RECEIVEING,
    //操作完成
    REQUEST_FINISHED,
    //产生错误
    REQUEST_ERROR,
    //已经取消
    REQUEST_CANCEL
}REQUEST_STATUS;

//下载完成回调
typedef void (^finishDownListener)(NSError *error);


@protocol UVHttpClientDelegate;

/**
    http请求封装类，支持get,post,upload,download等基本的请求操作，当前只支持同步请求 示例：
 
        UVHttpClient *http = [UVHttpClient instance];
        NSUrl *url = [NSUrl UrlWithString:@"http://www.163.com"];
        NSData *data = [http get:url];
 */
@interface UVHttpClient : NSMutableURLRequest
@property(nonatomic,weak) id<UVHttpClientDelegate> delegate;

//返回
@property(nonatomic,strong,readonly) NSHTTPURLResponse *response;
//http连接
@property(nonatomic,strong,readonly) NSURLConnection *connection;

//请求超时时间
@property(nonatomic,assign) NSTimeInterval timeout;
//返回格式编码 针对文本格式有效 设置错误的编码格式可以导致返回的内容乱码或没有任何内容
@property(nonatomic,assign) CFStringEncoding encode;
//json解析选项 参考[NSJSONSerialization JSONObjectWithData]方法
@property(nonatomic,assign) NSJSONReadingOptions jsonReadOption;
//请求Content Type，如果text/html text/css等。默认为text/html
@property(nonatomic,strong) NSString *contentType;
//http验证用户名
@property(nonatomic,strong) NSString *username;
//http验证密码
@property(nonatomic,strong) NSString *password;
//返回类型
@property(nonatomic,assign) RESPONSE_TYPE responseType;

+(UVHttpClient*)instance;
- (id)initWithDelegate:(id<UVHttpClientDelegate>)delegate_;

/**
 发送get请求
 */
- (id)get:(NSURL*)url_ error:(NSError **)error_;

/** 发送post请求
 
 @param NSURL url_ 请求的url
 @param NSArray  params 请求的参数 格式如:
    NSArray *param = @[{REQUEST_FIELD_NAME:@"键名1",REQUEST_FIELD_VALUE:@"值1"},{REQUEST_FIELD_NAME:@"键名2",REQUEST_FIELD_VALUE:@"值2"}];
    注意值只能是字符型 如果是数字也用字符表示
 @param NSError error_ 如果产生错误这里保存错误信息
 */
- (id)post:(NSURL*)url_ param:(NSArray*)params error:(NSError **)error_;

/**
 注：post表单必须设置contentType为： application/x-www-form-urlencoded
 */
- (id)postData:(NSURL*)url_ data:(NSData*)data_ error:(NSError **)error_;

/** 上传文件
 可以上传多个文件 如果本地文件不存在，则自动跳过
 
 @param NSURL url_ 请求的地址
 @param NSArray files 格式如 
    NSArray *file = @[{REQUEST_FIELD_NAME:@"键名1",REQUEST_FIELD_VALUE:<本地文件NSURL1>},{REQUEST_FIELD_NAME:@"键名2",REQUEST_FIELD_VALUE:<本地文件NSURL2>}];
 @param NSArray params 其它参数
 @param NSError error_ 如果产生错误 这里保存错误信息
 */
- (id)upload:(NSURL*)url_ files:(NSArray*)files_ param:(NSArray*)params error:(NSError **)error_;


/** 下载文件
 下载文件使用异步进行操作，下载过程中可以取消下载
 
 @param NSURL url_ 远程地址
 @param NSURL 本地保存的地址
 @param block 下载完成后回调 如果error不为空，表示出现了错误
 */
- (void)download:(NSURL*)url_ save:(NSString*)file_ finish:(finishDownListener)finish_;
- (void)cancelDownload;

//快捷方法 当前的请求是GB2312的编码
- (void)useGb2312Encode;
@end

@protocol UVHttpClientDelegate <NSObject>

@optional
- (void)onRequestStatus:(UVHttpClient*)sender_ status:(REQUEST_STATUS)status_;
- (void)onRequestReceiveing:(UVHttpClient*)sender_ total:(CGFloat)total_ finish:(CGFloat)finish_;
@end


