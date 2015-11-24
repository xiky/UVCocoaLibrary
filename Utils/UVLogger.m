//
//  UVLogger.m
//  syslogd
//
//  Created by chenjiaxin on 15/6/9.
//  Copyright (c) 2015年 chenjiaxin. All rights reserved.
//

#import "UVLogger.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <pthread.h>

#define __UVLOG_VERSION__ (@"1.2.0 build 20150611")

void myUncaughExceptionHandler(NSException *exception)
{
    NSArray *arr = [exception callStackSymbols];
    NSString *reasion = [exception reason];
    NSString *name = [exception name];
    
    NSString *content = [[NSString alloc] initWithFormat:@"crashed!name:%@,reason:\n%@\n%@",name,reasion,[arr componentsJoinedByString:@"\n"]];
    
    NSLog(@"%@",content);
 }


void InitCrashReport()
{
    // 1     linux错误信号捕获
//    for (int i = 0; i < s_fatal_signal_num; ++i) {
//        signal(s_fatal_signals[i], myUncaughExceptionHandler2);
//    }
    
    // 2      objective-c未捕获异常的捕获
    NSSetUncaughtExceptionHandler(&myUncaughExceptionHandler);
}


@implementation UVLogger
{
    int _sockfd;
    struct sockaddr_in _toAddr;
}
+(instancetype)instance
{
    static dispatch_once_t pred = 0;
    static UVLogger *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[UVLogger alloc] init];
    });
    return instance;
}
- (id)init
{
    if(self = [super init])
    {
        _level = UVLOG_LEVEL_DEBUG;
        _console = YES;
        _server = @"127.0.0.1";
        _port = __UVLOG_DEFAULT_PORT;
        _sockfd = 0;
        InitCrashReport();
        NSString *msg =[NSString stringWithFormat:@"\r\n\
                        -----------------UVLogger-----------------\r\n\
                                  %@\r\n\
                        ------------------------------------------\r\n", __UVLOG_VERSION__];
        [self print:msg];
    }
    return self;
}

- (void)setLevel:(UVLOG_LEVEL)level_
{
    _level = level_;
}
- (void)setConsole:(BOOL)console_
{
    _console = console_;
}
- (void)server:(NSString *)addr_
{
    [self server:addr_ port:__UVLOG_DEFAULT_PORT];
}
- (void)server:(NSString *)addr_ port:(NSInteger)port_
{
    _server = addr_;
    _port = port_;
    
    NSString *msg = [NSString stringWithFormat:@"%@Initialized,Version:%@",[self getPid],__UVLOG_VERSION__];
    
    NSString *sendmsg = [self formatSendLog:msg tag:__UVLOG_DEFAULT_TAG__];
    [self sendLog:sendmsg];
}


- (void)verbose:(NSString*)tag_ msg:(NSString*)msg_ file:(const char*)file_ fun:(const char*)fun_ line:(int)line_
{
    [self log:UVLOG_LEVEL_VERBOSE tag:tag_ msg:msg_ file:file_ fun:fun_ line:line_];
}
- (void)debug:(NSString*)tag_ msg:(NSString*)msg_ file:(const char*)file_ fun:(const char*)fun_ line:(int)line_
{
    [self log:UVLOG_LEVEL_DEBUG tag:tag_ msg:msg_ file:file_ fun:fun_ line:line_];
}
- (void)info:(NSString*)tag_ msg:(NSString*)msg_ file:(const char*)file_ fun:(const char*)fun_ line:(int)line_
{
    [self log:UVLOG_LEVEL_INFO tag:tag_ msg:msg_ file:file_ fun:fun_ line:line_];
}
- (void)warn:(NSString*)tag_ msg:(NSString*)msg_ file:(const char*)file_ fun:(const char*)fun_ line:(int)line_
{
    [self log:UVLOG_LEVEL_WARN tag:tag_ msg:msg_ file:file_ fun:fun_ line:line_];
}
- (void)error:(NSString*)tag_ msg:(NSString*)msg_ file:(const char*)file_ fun:(const char*)fun_ line:(int)line_
{
    [self log:UVLOG_LEVEL_ERROR tag:tag_ msg:msg_ file:file_ fun:fun_ line:line_];
}
- (void)assert:(NSString*)tag_ msg:(NSString*)msg_ file:(const char*)file_ fun:(const char*)fun_ line:(int)line_
{
    [self log:UVLOG_LEVEL_ASSERT tag:tag_ msg:msg_ file:file_ fun:fun_ line:line_];
}

- (void)log:(UVLOG_LEVEL)level_ tag:(NSString*)tag_ msg:(NSString*)msg_ file:(const char*)file_ fun:(const char*)fun_ line:(int)line_
{
    if(level_>=_level)
    {
        __weak UVLogger *weakSelf = self;
        NSString *body = [self formatBody:level_ msg:msg_ file:file_ fun:fun_ line:line_];
        
        NSString *sendMsg = [self formatSendLog:body tag:tag_];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [weakSelf sendLog:sendMsg];
        });
        
        if(_console)
        {
            NSString *consoleMsg = [self formatConsoleLog:body];
            [self print:consoleMsg];
        }
    }
}

- (void)dealloc
{
    [self close];
}

#pragma - private
- (NSString *)getTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:SSS"];
  
    NSString *date = [dateFormatter stringFromDate:[NSDate date]];
    NSString *timeNow = [NSString stringWithFormat:@"%@",date];
    return timeNow;
}
- (NSString*)formatBody:(UVLOG_LEVEL)level_ msg:(NSString*)msg_ file:(const char*)file_ fun:(const char*)fun_ line:(int)line_
{
    NSDictionary *levelArr = @{
                               @(UVLOG_LEVEL_VERBOSE):@"V",
                               @(UVLOG_LEVEL_DEBUG):@"D",
                               @(UVLOG_LEVEL_INFO):@"I",
                               @(UVLOG_LEVEL_WARN):@"W",
                               @(UVLOG_LEVEL_ERROR):@"E",
                               @(UVLOG_LEVEL_ASSERT):@"A"
                               };
    
    NSString *file = [NSString stringWithUTF8String:file_];
    NSArray *filelist = [file componentsSeparatedByString:@"/"];
    NSInteger count = filelist.count;
    if(count>3)
    {
        file = [NSString stringWithFormat:@"%@/%@",filelist[count - 2], filelist[count - 1]];
    }
    
    NSString *fun = [NSString stringWithUTF8String:fun_];
    fun = [fun stringByReplacingOccurrencesOfString:@"-" withString:@""];
    fun = [fun stringByReplacingOccurrencesOfString:@"+" withString:@""];
    //消息体格式（通用）： pid V 文件(行)函数 具体信息
    NSString *msg =[NSString stringWithFormat:@"%@ %@ %@(%d)%@ %@",[self getPid],levelArr[@(level_)], file,line_, fun,msg_];
    
    return msg;
}
- (NSString *)formatSendLog:(NSString*)msg_ tag:(NSString*)tag_
{
    //发送日志消息格式：<30> 时间 tag:具体消息
    NSString *msg = [NSString stringWithFormat:@"<30> %@ %@:%@",[self getTime], tag_,msg_];
    return msg;
}

- (NSString*)formatConsoleLog:(NSString*)msg_
{
    //输出到控制台消息格式：时间 具体消息
    NSString *msg = [NSString stringWithFormat:@"%@ %@",[self getTime],msg_];
    return msg;
}

- (NSString*) getPid
{
    NSString *msg = [NSString stringWithFormat:@"%@[5%d-5%d]"
                    ,[[NSProcessInfo processInfo] processName]
                    ,[[NSProcessInfo processInfo] processIdentifier]
                    ,pthread_mach_thread_np(pthread_self())
                    ];
    return msg;
}
- (void)sendLog:(NSString *)message_
{
    if(!_sockfd)
    {
        [self open];
    }
    if(_sockfd > 0)
    {
        size_t sendLen = 0;
        const char * pmsg = [message_ UTF8String];
        size_t len = strlen(pmsg);
        
        while (sendLen < len)
        {
            sendLen += sendto(_sockfd,pmsg+sendLen,len-sendLen,0,(struct sockaddr*)&_toAddr,sizeof(_toAddr));
        }
    }
}

- (BOOL)open
{
    [self close];
    _sockfd = socket(AF_INET,SOCK_DGRAM,IPPROTO_UDP);
    if(_sockfd < 0)
    {
        NSString *msg = [NSString stringWithFormat:@"open socket failure,ip:%@,port:%ld",_server,(long)_port];
        [self print:msg];
        return NO;
    }
    
    
    memset(&_toAddr,0,sizeof(_toAddr));
    _toAddr.sin_family = AF_INET;
    _toAddr.sin_addr.s_addr=inet_addr([_server UTF8String]);
    _toAddr.sin_port = htons(_port);
    
    return YES;
}

- (void)close
{
    if(_sockfd != 0)
    {
        close(_sockfd);
        memset(&_toAddr,0,sizeof(_toAddr));
        _sockfd = 0;
    }
}

- (void)print:(NSString*)msg_
{
    printf("%s\n",[msg_ UTF8String]);
}
                        
//- (NSString*)trimp:(NSString*)msg_
//{
//    //规避空格不能发送的问题 后期待优化
//    NSString *msg = [msg_ stringByReplacingOccurrencesOfString:@" " withString:@"　"];
//    msg = [msg stringByReplacingOccurrencesOfString:@":" withString:@"："];
//    return msg;
//}
@end
