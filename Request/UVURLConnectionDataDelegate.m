//  Copyright (c) 2014年 XXXX. All rights reserved.
// --------------------------------------------------------------------------------
// UVURLConnectionDataDelegate.m
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

#import "UVURLConnectionDataDelegate.h"

static UVURLConnectionDataDelegate *_instance = nil;
@interface UVURLConnectionDataDelegate () <NSURLConnectionDataDelegate>
{
    NSFileHandle *_file;
}
@end;
@implementation UVURLConnectionDataDelegate
{
    UVHttpClient *_client;
    long long _totalLength;
    NSInteger _finishLength;
}

#pragma mark - init
-(void)initData
{
    _status = REQUEST_STARTING;
    _totalLength = 0;
    _file = nil;
    _finishLength = 0;
}

- (id)init
{
    if(self = [super init])
    {
        [self initData];
    }
    return self;
}

+ (UVURLConnectionDataDelegate*)instance
{
    static dispatch_once_t pred = 0;
    
    dispatch_once(&pred, ^{
        _instance = [[UVURLConnectionDataDelegate alloc] init];
    });
    return _instance;
}

- (id)initWithClient:(UVHttpClient*)client delegate:(id<UVHttpClientDelegate>)delegate_
{
    if(self = [super init])
    {
        [self initData];
        _client = client;
        _delegate = delegate_;
    }
    return self;
}
- (id)initWithDownClient:(UVHttpClient*)client_ delegate:(id<UVHttpClientDelegate>)delegate_ down:(NSString*)path_ finish:(finishDownListener)finish_
{
    
    if(self = [self initWithClient:client_ delegate:delegate_])
    {
        NSError *error;
        NSFileManager *fp = [NSFileManager defaultManager];
        BOOL dirc = NO;
        if([fp fileExistsAtPath:path_ isDirectory:&dirc])
        {
            NSLog(@"fileExistsAtPath:%@,del it",path_);
            [fp removeItemAtPath:path_ error:&error];
            error = nil;
        }
        BOOL result = [fp createFileAtPath:path_ contents:nil attributes:nil];
        if(!result)
        {
            NSDictionary *info = @{NSLocalizedDescriptionKey:@"创建文件失败，请确认文件是否已经存在"};
            error = [NSError errorWithDomain:@"UVHttpClient" code:-1 userInfo:info];
            [self triggerError:error finish:finish_];
            return nil;
        }
        _file = [NSFileHandle fileHandleForUpdatingAtPath:path_];
        if(error != nil)
        {
            NSLog(@"initWithDownClient error:%@,path:%@",error,path_);
            [self triggerError:error finish:finish_];
            return nil;
        }
        _downFilePath = path_;
        _finishDownBlock = finish_;
    }
    return self;
}
- (BOOL)isFinished
{
    return (_status == REQUEST_FINISHED || _status == REQUEST_CANCEL || _status == REQUEST_ERROR)?YES:NO;
}
#pragma  mark - delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response
{
    if(!_file)
    {
        _data = [[NSMutableData alloc] init];
    }
    _response = (NSHTTPURLResponse*)response;
    _totalLength = _response.expectedContentLength;
    if(_totalLength<=0)
    {
        _totalLength = 0;
    }
    NSLog(@"didReceiveResponse,mimeType:%@,charset:%@,length:%lld,filename:%@,status:%ld",_response.MIMEType,_response.textEncodingName,_response.expectedContentLength,_response.suggestedFilename,(long)_response.statusCode);
    [self triggerStatus:REQUEST_RESPONSED];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _error = nil;
    [self triggerStatus:REQUEST_FINISHED];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    _error = error;
    _data = nil;
    [self triggerStatus:REQUEST_ERROR];
}
//- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
//{
////    [self triggerStatus:REQUEST_CANCEL];
//}
//- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
//{
//    return NO;
//}

//下面两段是重点，要服务器端单项HTTPS 验证，iOS 客户端忽略证书验证。
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    NSString *method = protectionSpace.authenticationMethod;
    NSLog(@"method:%@",method);
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSString *method = challenge.protectionSpace.authenticationMethod;
    NSLog(@"method:%@,name:%@,pass:%@",method,_username,_password);
    //https验证
    if ([method isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        [[challenge sender]  useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        
        [[challenge sender]  continueWithoutCredentialForAuthenticationChallenge: challenge];
    }
    //http服务器需要用户名或密码验证
    else if([method isEqualToString:NSURLAuthenticationMethodDefault])
    {
        NSURLCredential *newCredential;
        newCredential = [NSURLCredential credentialWithUser:_username
                                                   password:_password
                                                persistence:NSURLCredentialPersistenceNone];
        [[challenge sender] useCredential:newCredential
               forAuthenticationChallenge:challenge];
    }
}

//处理数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(_file)
    {
        [_file writeData:data];
    }
    else
    {
        [_data appendData:data];
    }
    _finishLength += data.length;
    [self triggerProgress];
    //NSLog(@"didReceiveData,length:%d",(int)data.length);
}

- (void)triggerStatus:(REQUEST_STATUS)status_
{
    _status = status_;
    if([self isFinished])
    {
        if(_file)
        {
            [_file closeFile];
            _file = nil;
        }
    }
    if(_status == REQUEST_FINISHED || _status == REQUEST_CANCEL || _status == REQUEST_ERROR)
    {
        if(_finishDownBlock != nil)
        {
            _finishDownBlock(_error);
        }
    }
    if(_delegate && [_delegate respondsToSelector:@selector(onRequestStatus:status:)])
    {
        [_delegate onRequestStatus:_client status:_status];
    }
    
}

- (void)triggerProgress
{
    _status = REQUEST_RECEIVEING;
    if(_delegate && [_delegate respondsToSelector:@selector(onRequestReceiveing:total:finish:)])
    {
        [_delegate onRequestReceiveing:_client total:_totalLength finish:_finishLength];
    }
}

- (void)triggerError:(NSError*)error_ finish:(finishDownListener)finish_
{
    [self triggerStatus:REQUEST_ERROR];
    if(finish_)
    {
        finish_(error_);
    }
}
@end
