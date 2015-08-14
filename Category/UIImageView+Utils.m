//
//  UIImageView+Utils.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/8/4.
//  Copyright (c) 2015年 Uniview. All rights reserved.
//

#import "UIImageView+Utils.h"
#import "UVUtils.h"
#import "UVHttpClient.h"
#import "UVRequest.h"
#import "UVError.h"
@implementation UIImageView (Utils)


- (void)imageWithRemoteUrl:(NSString*)url_ holder:(UIImage*)holder_
{
    if(url_.length < 1)
    {
        return;
    }
    self.image = holder_;
    NSArray *paths =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true);
    NSString *path = paths[0];
    path = [path stringByAppendingPathComponent:@"pictures"];
    NSFileManager *f = [NSFileManager defaultManager];
    if(![f fileExistsAtPath:path])
    {
        [f createDirectoryAtPath:path withIntermediateDirectories:TRUE attributes:nil error:nil];
    }
    
    NSString *filename = [UVUtils md5passwd:url_];
    NSString *full = [path stringByAppendingPathComponent:filename];
    if(![f fileExistsAtPath:full])
    {
        
        UVRequest *request = [[UVRequest alloc] init];
        
        __weak UIImageView *Self = self;
        [request exec:^{
            UVHttpClient *http = [[UVHttpClient alloc] init];
            http.responseType = RESPONSE_TYPE_BYTES;
            NSError *error;
            NSData *data = [http get:[NSURL URLWithString:url_] error:&error];
            if(!data || data == nil)
            {
                @throw [UVError errorWithCodeAndMessage:-1 message:@""];
            }
            [data writeToFile:full atomically:YES];
            
        } finish:^(UVError *error) {
            if(error != nil)return ;
            [Self imageWithLocalUrl:full];
        } showProgressInView:nil message:nil showToast:NO];
    }
    else
    {
        [self imageWithLocalUrl:full];
    }
}
- (void)imageWithLocalUrl:(NSString*)url_
{
    NSData *data = [NSData dataWithContentsOfFile:url_];
    if(data)
    {
        UIImage *image = [UIImage imageWithData:data];
        if(image)
        {
            self.image = image;
        }
    }
}
- (void)cleanCache:(NSString*)url_
{
    NSArray *paths =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true);
    NSString *path = paths[0];
    path = [path stringByAppendingPathComponent:@"pictures"];
    NSString *filename = [UVUtils md5passwd:url_];
    NSString *full = [path stringByAppendingPathComponent:filename];
    
    NSFileManager *f = [NSFileManager defaultManager];
    if([f fileExistsAtPath:full])
    {
        NSError *error;
        [f removeItemAtPath:full error:&error];
    }
}
- (BOOL)isCache:(NSString*)url_
{
    NSArray *paths =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true);
    NSString *path = paths[0];
    path = [path stringByAppendingPathComponent:@"pictures"];
    NSString *filename = [UVUtils md5passwd:url_];
    NSString *full = [path stringByAppendingPathComponent:filename];
    
    NSFileManager *f = [NSFileManager defaultManager];
    return [f fileExistsAtPath:full];
}
@end
