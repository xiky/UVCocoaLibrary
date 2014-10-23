//  Copyright (c) 2014年 XXXX. All rights reserved.
// --------------------------------------------------------------------------------
// UVHttpClient.m
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
#import <MobileCoreServices/MobileCoreServices.h>
#import "UVHttpClient.h"
#import "UVURLConnectionDataDelegate.h"
#import "XMLReader.h"


//文件上传相关常量定义
const NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";

//每个字段的分界线 --AaB03x
const NSString *MPboundary=@"--AaB03x";
//最后结束符 --AaB03x--
const NSString *endMPboundary=@"--AaB03x--";


static UVHttpClient *_requestinstance = nil;
@interface UVHttpClient ()

@end

@implementation UVHttpClient
{
    
}

- (void)initData
{
    _responseType = RESPONSE_TYPE_BYTES;
    _timeout = 30;
    _encode = kCFStringEncodingUTF8;
    //默认的contentType为text/html
   _contentType = @"text/html";
    _jsonReadOption = NSJSONReadingMutableContainers;
    
    [self setTimeoutInterval:_timeout];
    [self setValue:_contentType forHTTPHeaderField:@"Content-Type"];
    UIDevice *device = [UIDevice currentDevice];
    NSString *ua = [NSString stringWithFormat:@"httpclient/1.0 (%@; %@ %@)",device.model,device.systemName,device.systemVersion];
    [self setValue:ua forHTTPHeaderField:@"User-Agent"];
    device = nil;
    ua = nil;
}
- (id)initWithDelegate:(id<UVHttpClientDelegate>)delegate_
{
    self = [self init];
    _delegate = delegate_;
    return self;
    
}
- (id)init
{
    if(self = [super init])
    {
       [self initData];
    }
    return self;
}

+(UVHttpClient*)instance
{
    static dispatch_once_t predUVHttpClient = 0;
    dispatch_once(&predUVHttpClient, ^{
        _requestinstance = [[UVHttpClient alloc] init];
    });
    return _requestinstance;
}
- (void)setEncode:(CFStringEncoding)encode
{
    _encode = encode;
}
- (void)useGb2312Encode
{
    [self setEncode:kCFStringEncodingGB_18030_2000];
}
- (void)setContentType:(NSString *)contentType
{
    _contentType = contentType;
    [self setValue:_contentType forHTTPHeaderField:@"Content-Type"];
}

- (id)get:(NSURL*)url_ error:(NSError **)error_
{
    [self setURL:url_];
    [self setHTTPMethod:@"GET"];
    return [self sendRequest:error_];
}

- (id)post:(NSURL*)url_ param:(NSArray*)params error:(NSError **)error_
{
    NSMutableString *param = [self processParam:params];
    NSLog(@"url:%@,param:%@",url_, param);
    NSData *body = nil;
    if(params != nil)
    {
        body = [param dataUsingEncoding:NSUTF8StringEncoding];
        param = nil;
    }
    params = nil;
    
    return [self postData:url_ data:body error:error_];
}
- (id)postData:(NSURL*)url_ data:(NSData*)data_ error:(NSError **)error_
{
    [self setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [self setURL:url_];
    [self setHTTPMethod:@"POST"];
    //[self setContentType:@"application/x-www-form-urlencoded"];
    if(data_ != nil)
    {
        [self setHTTPBody:data_];
    }
    return [self sendRequest:error_];
}
- (id)upload:(NSURL*)url_ files:(NSArray*)files_ param:(NSArray*)params error:(NSError **)error_
{
    /* 文件上传表单表头格式
    Content-type: multipart/form-data, boundary=AaB03x
    
    --AaB03x
    content-disposition: form-data; name="field1"
    
    Hello Boris!
    --AaB03x
    content-disposition: form-data; name="pic"; filename="boris.png"
    Content-Type: image/png
    
    ... contents of boris.png ...
    --AaB03x--
     */
    [self setURL:url_];
    [self setHTTPMethod:@"POST"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    [self setContentType:contentType];
    
    NSMutableData *body = [[NSMutableData alloc] init];
    //自定义的字段参数
    NSMutableString *str = [self processFileFormParam:params];
    if(str != nil)
    {
        [body appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
        str = nil;
    }
    //加入文件列表
    NSString *key;
    NSURL *value;
    NSMutableData *tmpData;
    for(NSDictionary *item in files_)
    {
        key  = item[REQUEST_FIELD_NAME];
        value = item[REQUEST_FIELD_VALUE];
        tmpData = [self processFile:key path:value];
        if(tmpData != nil)
        {
            [body appendData:tmpData];
            tmpData = nil;
        }
    }
    //加入结束标记
    [body appendData:[endMPboundary dataUsingEncoding:NSUTF8StringEncoding]];
    [self setHTTPBody:body];
    [self setValue:[NSString stringWithFormat:@"%lu",(unsigned long)body.length] forHTTPHeaderField:@"Content-Length"];
    body = nil;
    
    return [self sendRequest:error_];
}
/** 下载文件
 下载文件使用异步进行操作，下载过程中可以取消下载
 
 @param NSURL url_ 远程地址
 @param NSURL 本地保存的地址
 @param block 下载完成后回调 如果error不为空，表示出现了错误
 */
- (void)download:(NSURL*)url_ save:(NSURL*)file_ finish:(finishDownListener)finish_
{
    [self setURL:url_];
    [self setHTTPMethod:@"GET"];
    [self setContentType:@"Content-type: application/octet-stream"];
    NSLog(@"download,url:%@,save:%@",self.URL,file_);
    UVURLConnectionDataDelegate *delegate = [[UVURLConnectionDataDelegate alloc] initWithDownClient:self delegate:_delegate down:file_ finish:finish_ ];
    delegate.username = _username;
    delegate.password = _password;
    if(delegate == nil)
    {
        return;
    }
    _connection = [NSURLConnection connectionWithRequest:self delegate:delegate];
    if(!_connection)
    {
        NSDictionary *info = @{NSLocalizedDescriptionKey:@"创建connection失败"};
        NSError *error = [NSError errorWithDomain:@"UVHttpClient" code:-1 userInfo:info];
        delegate = nil;
        info = nil;
        [self triggerStatus:REQUEST_ERROR];
        if(finish_ != nil)
        {
            finish_(error);
        }
        return;
    }
    _response = delegate.response;
    [self triggerStatus:REQUEST_STARTING];
    _delegate = nil;
}
- (void)cancelDownload
{
    [_connection cancel];
}
#pragma mark - private
- (NSData*)sendRequest:(NSError **)error_;
{
    UVURLConnectionDataDelegate *delegate = [[UVURLConnectionDataDelegate alloc] initWithClient:self delegate:_delegate];
    delegate.username = _username;
    delegate.password = _password;
    _connection = [NSURLConnection connectionWithRequest:self delegate:delegate];
    if(!_connection)
    {
        NSDictionary *info = @{NSLocalizedDescriptionKey:@"创建connection失败"};
        *error_ = [NSError errorWithDomain:@"UVHttpClient" code:-1 userInfo:info];
        delegate = nil;
        info = nil;
        [self triggerStatus:REQUEST_ERROR];
        return nil;
    }
    [self triggerStatus:REQUEST_STARTING];
    //堵塞线程，等待结束
    NSDate *date = [NSDate date];
	while(![delegate isFinished])
    {
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1f]];
        if([[NSDate date] timeIntervalSinceDate:date]>_timeout)
        {
            NSDictionary *info = @{NSLocalizedDescriptionKey:@"连接超时"};
            *error_ = [NSError errorWithDomain:@"UVHttpClient" code:-1 userInfo:info];
            delegate = nil;
            date = nil;
            info = nil;
            [self triggerStatus:REQUEST_ERROR];
            return nil;
        }
	}
    _response = delegate.response;
    
    NSData *data = nil;
    if(delegate.error)
    {
        *error_ = delegate.error;
    }
    else if(delegate.data!=nil)
    {
        data = [self covertData:delegate.data error:error_];
    }
    //NSLog(@"_res:%@,data:%@",self.response,delegate.data);
    delegate = nil;
    date = nil;    
    return data;
}
//处理post的参数
- (NSMutableString*)processParam:(NSArray*)params_
{
    NSString *key,*value;
    NSMutableString *paramString;
    NSArray *keys;
    if(params_ == nil)
    {
        return nil;
    }
    
    paramString = [[NSMutableString alloc] init];
    for(NSDictionary *item in params_)
    {
        key = item[REQUEST_FIELD_NAME];
        //key = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        value = item[REQUEST_FIELD_VALUE];
        if([value.class isSubclassOfClass:[NSString class]])
        {
            value =[value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        [paramString appendFormat:@"%@=%@&", key, value];
        value = nil;
        key = nil;
    }
    keys = nil;
    [paramString deleteCharactersInRange:NSMakeRange([paramString length] - 1, 1)];
    params_ = nil;
    return paramString;
}
//处理带有文件的表单参数
- (NSMutableString*)processFileFormParam:(NSArray*)params_
{
    NSString*key, *value;
    NSMutableString *paramString;
    if(params_!=nil)
    {
        paramString = [[NSMutableString alloc] init];
        for(NSDictionary *item in params_)
        {
            key = item[REQUEST_FIELD_NAME];
            if([key.class isSubclassOfClass:[NSString class]])
            {
                key = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
            //value
            value = item[REQUEST_FIELD_VALUE];
            if([value.class isSubclassOfClass:[NSString class]])
            {
                value = [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
            //添加分界线，换行
            [paramString appendFormat:@"%@\r\n",MPboundary];
            //添加字段名称，换2行
            [paramString appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
            //添加字段的值
            [paramString appendFormat:@"%@\r\n",value];
            key = nil;
        }
    }
    return paramString;
}
/** 处理文件参数
 如果文件不存在或读取文件失败会自动跳过
 
 @param NSString name_ 键名
 @param NSURL path_ 文件路径
 @return NSMutableData body_ 要加入的二进制流
 */
- (NSMutableData*)processFile:(NSString*)name_ path:(NSURL*)path_
{
    NSFileManager *file = [NSFileManager defaultManager];
    if(![file fileExistsAtPath:path_.path])
    {
        file = nil;
        NSLog(@"name_:%@,path:%@,file not exists",name_,path_);
        return nil;
    }
    file = nil;
    NSData *data = [NSData dataWithContentsOfURL:path_];
    if(!data)
    {
        NSLog(@"name_:%@,path:%@,read file failure",name_,path_);
        return nil;
    }
    NSMutableData *body = [[NSMutableData alloc] init];
    //读取文件的miniType 类似 image/png 等
    NSString *mimeType = [self getMimeType:path_];
    NSMutableString *paramString = [[NSMutableString alloc] init];
    //添加分界线，换行
    [paramString appendFormat:@"%@\r\n",MPboundary];
    //声明pic字段，文件名为boris.png
    [paramString appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",name_,[path_ lastPathComponent]];
    //声明上传文件的格式
    [paramString appendFormat:@"Content-Type: %@\r\n\r\n",mimeType];
    //加入字段头
    [body appendData:[paramString dataUsingEncoding:NSUTF8StringEncoding]];
    //文件内容
    [body appendData:data];
    
    NSString *swap = [NSString stringWithFormat:@"\r\n"];
    [body appendData:[swap dataUsingEncoding:NSUTF8StringEncoding]];
    
    data = nil;
    paramString = nil;
    mimeType = nil;
    return body;
}
- (BOOL)isTextResonseType
{
    BOOL result =  (_responseType == RESPONSE_TYPE_TEXT || _responseType == RESPONSE_TYPE_JSON || _responseType == RESPONSE_TYPE_XML)?YES:NO;
    return result;
}
- (NSString*)getMimeType:(NSURL*)url_
{
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[url_ pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    NSString *mimeType = (__bridge NSString*)MIMEType;
    CFRelease(MIMEType);
    CFRelease(UTI);
    return mimeType;
}
- (id)covertData:(NSData*)data_ error:(NSError**)error_
{
    if(data_ == nil)return nil;
    id result = data_;
    NSStringEncoding encoding =
    CFStringConvertEncodingToNSStringEncoding(_encode);
    
    switch (_responseType)
    {
            case RESPONSE_TYPE_XML:
            result = [XMLReader dictionaryForXMLData:data_ error:error_];
            break;
            case RESPONSE_TYPE_TEXT:
            result = [[NSString alloc] initWithData:data_ encoding:encoding];
            break;
            case RESPONSE_TYPE_JSON:
            result = [NSJSONSerialization JSONObjectWithData:data_ options:_jsonReadOption error:error_];
            break;
            case RESPONSE_TYPE_IMAGE:
            result = [UIImage imageWithData:data_];
            break;
        default:
            break;
    }
    data_ = nil;
    return result;
}

#pragma mark - delegate
- (void)triggerStatus:(REQUEST_STATUS)status_
{
    if(_delegate && [_delegate respondsToSelector:@selector(onRequestStatus:status:)])
    {
        [_delegate onRequestStatus:self status:status_];
    }
}

@end

