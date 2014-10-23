//
//  UVError.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 13-12-11.
//  Copyright (c) 2013年 XXXX. All rights reserved.
//

#import "UVError.h"

static UVError *_instance = nil;
@interface UVError ()
@property(nonatomic,assign) NSInteger code;
@property(nonatomic,strong) NSString *message;
@end

@implementation UVError

+(UVError*)instance
{
    static dispatch_once_t pred = 0;
    
    dispatch_once(&pred, ^{
        _instance = [[UVError alloc] init];
    });
    return _instance;
}

+ (id)errorWithCodeAndMessage:(NSInteger)code_ message:(NSString*)msg_
{
    UVError *error = [UVError instance];
    error.code = code_;
    error.message = msg_;
    return error;
}

+ (id)errorWithNSError:(NSError*)error_
{
    UVError *error = [UVError instance];
    error.code = error_.code;
    error.message = error_.localizedDescription;
    error.orginalError = error_;
    return error;
}

-(NSString*)description
{
    NSString *string = [NSString stringWithFormat:@"code:%ld,message:%@",(long)_code,_message];
    return string;
}
@end
