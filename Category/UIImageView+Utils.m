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


- (void)imageWithRemoteUrl:(NSURL*)url_ holder:(UIImage*)holder_
{
    self.image = holder_;
    NSArray *paths =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true);
    NSString *path = paths[0];
    path = [path stringByAppendingPathComponent:@"pictures"];
    NSFileManager *f = [NSFileManager defaultManager];
    if(![f fileExistsAtPath:path])
    {
        [f createDirectoryAtPath:path withIntermediateDirectories:TRUE attributes:nil error:nil];
    }
    
    NSString *filename = [UVUtils md5passwd:url_.absoluteString];
    NSString *full = [path stringByAppendingPathComponent:filename];
    if(![f fileExistsAtPath:full])
    {
        
        UVRequest *request = [[UVRequest alloc] init];
        
        __weak UIImageView *Self = self;
        [request exec:^{
            UVHttpClient *http = [[UVHttpClient alloc] init];
            http.responseType = RESPONSE_TYPE_BYTES;
            NSError *error;
            NSData *data = [http get:url_ error:&error];
            if(!data || data == nil)
            {
                @throw [UVError errorWithCodeAndMessage:-1 message:@""];
            }
            [data writeToFile:full atomically:YES];
            
        } finish:^(UVError *error) {
            if(error != nil)return ;
            [Self imageWithLocalUrl:[NSURL URLWithString:full]];
        } showProgressInView:nil message:nil showToast:NO];
    }
    else
    {
        [self imageWithLocalUrl:[NSURL URLWithString:full]];
    }
}
- (void)imageWithLocalUrl:(NSURL*)url_
{
    NSData *data = [NSData dataWithContentsOfURL:url_];
    if(data)
    {
        UIImage *image = [UIImage imageWithData:data];
        if(image)
        {
            self.image = image;
        }
    }
}
- (void)cleanCache:(NSURL*)url_
{
    NSArray *paths =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true);
    NSString *path = paths[0];
    path = [path stringByAppendingPathComponent:@"pictures"];
    NSString *filename = [UVUtils md5passwd:url_.absoluteString];
    NSString *full = [path stringByAppendingPathComponent:filename];
    
    NSFileManager *f = [NSFileManager defaultManager];
    if([f fileExistsAtPath:path])
    {
        NSError *error;
        [f removeItemAtPath:full error:&error];
    }
}
@end
