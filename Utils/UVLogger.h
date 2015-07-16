/*
UVLogger.h

 Created by chenjiaxin on 15/6/9.
 Copyright (c) 2015年 chenjiaxin. All rights reserved.
 
-----------
 date                       author                       desc                       verion
 2015-06-09           chenjiaxin                  create                     1.0.0
 2015-06-10           chenjiaxin                  精简日志                 1.1.0
 2015-06-11           chenjiaxin                  引入syslogd格式     1.1.1
 2015-06-12           chenjiaxin                  增加crash捕获         1.2.0
 
 
 如果想将日志反馈到syslogd服务器，则需要进行如下设置
1、打开mac syslogd，在终端执行如下命令：
 cd /System/Library/LaunchDaemons
 sudo /usr/libexec/PlistBuddy -c "add :Sockets:NetworkListener dict" com.apple.syslogd.plist
 sudo /usr/libexec/PlistBuddy -c "add :Sockets:NetworkListener:SockServiceName string syslog" com.apple.syslogd.plist
 sudo /usr/libexec/PlistBuddy -c "add :Sockets:NetworkListener:SockType string dgram" com.apple.syslogd.plist
 sudo launchctl unload com.apple.syslogd.plist
 sudo launchctl load com.apple.syslogd.plist
 
 2、使用命令查看514端口是否开放： netstat -p UDP -nl|grep 514
 3、使用命令测试发布日志： nc -w0 -u 127.0.0.1 514  <<<"mylog:teststs"
 
 使用示例：
 [[UVLogger  instance] server:@"10.17.36.30"];
 UVLog(@"UVLogE s:%@,i=%d",@"11212",2222);
 
 应用程序结束后，建议使用:
    [[UVLogger instance] dealloc]
 关闭socket连接
 
 打开 控制台(Launchpad->其它->控制台)，如果正常则能在日志列表里面看到上面的日志
 */
#import <Foundation/Foundation.h>
#define __UVLOG_DEFAULT_PORT (514)

/**
 改变TAG的值，可自行定义__UVLOG_DEFAULT_TAG__
 */
#ifndef __UVLOG_DEFAULT_TAG__
#define __UVLOG_DEFAULT_TAG__ (@"UVLogger")
#endif
/**
 日志开关宏,在发布应用的时候 需要定义宏来取消日志输出
 <ol>
 <li>开启日志输出:#define UVLOG_DISABLE (1)
 <li>关闭日志输出:#define UVLOG_DISABLE (0) 或者不定义
 </ol>
 */
#if UVLOG_DISABLE

#define UVLogE(fmt, ...)
#define UVLogW(fmt, ...)
#define UVLogI(fmt, ...)
#define UVLogD(fmt, ...)
#define UVLogV(fmt, ...)
#define UVLogA(fmt, ...)

#else

#define UVLogE(fmt, ...)   [[UVLogger instance] error:__UVLOG_DEFAULT_TAG__ msg:([NSString stringWithFormat:(fmt),##__VA_ARGS__]) file:__FILE__ fun:__func__  line:__LINE__]
#define UVLogW(fmt, ...)   [[UVLogger instance] warn:__UVLOG_DEFAULT_TAG__ msg:([NSString stringWithFormat:(fmt),##__VA_ARGS__]) file:__FILE__ fun:__func__  line:__LINE__]
#define UVLogI(fmt, ...)   [[UVLogger instance] info:__UVLOG_DEFAULT_TAG__ msg:([NSString stringWithFormat:(fmt),##__VA_ARGS__]) file:__FILE__ fun:__func__  line:__LINE__]
#define UVLogD(fmt, ...)   [[UVLogger instance] debug:__UVLOG_DEFAULT_TAG__ msg:([NSString stringWithFormat:(fmt),##__VA_ARGS__]) file:__FILE__ fun:__func__  line:__LINE__]
#define UVLogV(fmt, ...)   [[UVLogger instance] verbose:__UVLOG_DEFAULT_TAG__ msg:([NSString stringWithFormat:(fmt),##__VA_ARGS__]) file:__FILE__ fun:__func__  line:__LINE__]
#define UVLogA(fmt, ...)   [[UVLogger instance] assert:__UVLOG_DEFAULT_TAG__ msg:([NSString stringWithFormat:(fmt),##__VA_ARGS__]) file:__FILE__ fun:__func__  line:__LINE__]

#define UVLog(fmt, ...) UVLogD(fmt,##__VA_ARGS__)
#define NSLog(fmt, ...) UVLog(fmt,##__VA_ARGS__)
#endif



/**
 * 可用的日志等级
 * @see <a> + (void)setLogLevel:(XCLOG_LEVEL)level</a>
 */
typedef NS_ENUM(NSInteger,UVLOG_LEVEL)
{
    /**
     *  VERBOSE将显示所有日志
     */
    UVLOG_LEVEL_VERBOSE = 0,
    
    /**
     *  DEBUG等级将显示DEBUG,INFO,WARN,ASSERT
     */
    UVLOG_LEVEL_DEBUG,
    
    /**
     *  INFO将显示INFO,WARN,ERROR,ASSERT
     */
    UVLOG_LEVEL_INFO,
    
    /**
     *  WARN将显示WARN,ERROR,ASSERT
     */
    UVLOG_LEVEL_WARN,
    /**
     *  ERROR将显示ERROR,ASSERT
     */
    UVLOG_LEVEL_ERROR,
    
    /**
     * ASSERT
     */
    UVLOG_LEVEL_ASSERT,
    
};

@interface UVLogger : NSObject

@property (nonatomic,assign,readonly) UVLOG_LEVEL level;
@property (nonatomic,assign,readonly) BOOL console;
@property (nonatomic,strong,readonly) NSString *server;
@property(nonatomic,assign,readonly) NSInteger port;

+ (instancetype)instance;
- (void)setLevel:(UVLOG_LEVEL)level_;
- (void)setConsole:(BOOL)console_;
- (void)server:(NSString *)addr_;
- (void)server:(NSString *)addr_ port:(NSInteger)port_;
- (void)dealloc;


- (void)verbose:(NSString*)tag_ msg:(NSString*)msg_ file:(const char*)file_ fun:(const char*)fun_ line:(int)line_;
- (void)debug:(NSString*)tag_ msg:(NSString*)msg_ file:(const char*)file_ fun:(const char*)fun_ line:(int)line_;
- (void)info:(NSString*)tag_ msg:(NSString*)msg_ file:(const char*)file_ fun:(const char*)fun_ line:(int)line_;
- (void)warn:(NSString*)tag_ msg:(NSString*)msg_ file:(const char*)file_ fun:(const char*)fun_ line:(int)line_;
- (void)error:(NSString*)tag_ msg:(NSString*)msg_ file:(const char*)file_ fun:(const char*)fun_ line:(int)line_;
- (void)assert:(NSString*)tag_ msg:(NSString*)msg_ file:(const char*)file_ fun:(const char*)fun_ line:(int)line_;

- (void)log:(UVLOG_LEVEL)level_ tag:(NSString*)tag_ msg:(NSString*)msg_ file:(const char*)file_ fun:(const char*)fun_ line:(int)line_;
@end
