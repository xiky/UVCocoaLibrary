//
//  UIImage+Utils.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 10/11/13.
//  Copyright (c) 2013 XXXX. All rights reserved.
//

#import "UIImage+UVUtils.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UVError.h"
#import "UVHttpClient.h"
#import "UVUtils.h"
#import "NSString+UVUtils.h"
@implementation UIImage (UVUtils)

/**
 * 在图片中写入文字
 * @params font_ 文字的字体
 * @params rect_ 写入文字的位置
 * @return UIImage 返回一个新的图像
 */
-(UIImage*)uv_writeText:(NSString*)text_ font:(UIFont*)font_ rect:(CGRect)rect_
{
    //NSLog(@"writetext:%@,width:%f,height:%f",text_,rect_.size.width,rect_.size.height);
    CGSize size = self.size;
    //开始图像句柄
    UIGraphicsBeginImageContextWithOptions(size,
                                           YES,                     // Opaque
                                           self.scale);             // Use image scale
    //获取当前图像句柄
    CGContextRef context = UIGraphicsGetCurrentContext();
    //在当前句柄中写入当前图像
    [self drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    
    //开始写入文字
    CGContextSetLineWidth(context, 1.0);
    //使用红色 alpha为1
    CGContextSetRGBFillColor (context, 1.0, 0.0, 0.0, 1.0);
    //在指定区域写文字
    [text_ drawInRect:rect_ withFont:font_];
    //返回修改后的图片
    UIImage *rotatedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return rotatedImage;
}

-(UIImage*)uv_writeText:(NSString*)text_
{
    
    UIFont *font = [UIFont boldSystemFontOfSize:36.0];
    return [self uv_writeText:text_ font:font];
}
-(UIImage*)uv_writeText:(NSString*)text_ font:(UIFont*)font_
{
    //自适应字体
    CGSize size = [text_ sizeWithFont:font_];
    CGRect rect = CGRectMake(20, 40, size.width, size.height);
    return [self uv_writeText:text_ font:font_ rect:rect];
}

/**
 * 存储到本地
 */
-(BOOL)uv_saveToJpg:(NSURL*)url_
{
    NSData *imageData = UIImageJPEGRepresentation(self, 0);
    
    BOOL result = [imageData writeToURL:url_ atomically:YES];
    return result;
}

//UIImage 缩放到指定大小
- (UIImage *)uv_scaleToSize:(CGSize)size
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
    
//    
//    //CGSize size = [[_imgInfo objectForKey:HOLDSIZE] CGSizeValue];
//    size.width = size.width*2;
//    size.height = size.height*2;
//    CGSize imageSize = self.size;
//    
//    CGSize scalesize = CGSizeZero;
//    
//    CGFloat imageScale = imageSize.width/imageSize.height;
//    CGFloat sizeScale = size.width/size.height;
//    
//    if(sizeScale>=imageScale){
//        scalesize.width = imageSize.width;
//        scalesize.height = imageSize.width/sizeScale;
//    }else if(sizeScale<imageScale){
//        scalesize.height = imageSize.height;
//        scalesize.width = imageSize.height*sizeScale;
//    }
//    
//    CGRect rect = CGRectMake((imageSize.width-scalesize.width)/2, (imageSize.height-scalesize.height)/2, scalesize.width, scalesize.height);
//    CGImageRef sourceImageRef = [self CGImage];
//    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
//    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
//    
//    UIGraphicsBeginImageContext(size);
//    [newImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    NSData *data = UIImagePNGRepresentation(reSizeImage);
//    
//    return [UIImage imageWithData:data];

//    self.image = UIImagePNGRepresentation(reSizeImage);
//
//    // 创建一个bitmap的context
//    // 并把它设置成为当前正在使用的context
//    UIGraphicsBeginImageContext(size);
//    // 绘制改变大小的图片
//    [self drawInRect:CGRectMake(size.width/8, size.height/8, size.width*0.75, size.height*0.75)];
//    // 从当前context中创建一个改变大小后的图片
//    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    // 使当前的context出堆栈
//    UIGraphicsEndImageContext();
//    // 返回新的改变大小后的图片
//    return scaledImage;
}

- (void)uv_saveToPhotoAlbum:(void (^)(NSURL *assetURL, UVError *error))finish_;
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library writeImageToSavedPhotosAlbum:[self CGImage]
                              orientation:(ALAssetOrientation)[self imageOrientation]
                          completionBlock:^(NSURL *assetURL, NSError *error_)
    {
        if(finish_ != nil)
        {
            UVError *error = nil;
            if(error_)
            {
                error = [UVError errorWithNSError:error_];
            }
            finish_(assetURL,error);
        }
    }];
    
}

+ (UIImage *) uv_imageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *) uv_imageWithGradient:(CGRect)rectArea colorStart:(UIColor*) startColor colorEnd:(UIColor*)endColor
{
    CGRect rect = rectArea;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef colorSpace =  CGColorSpaceCreateDeviceRGB();
    
    CGFloat *startColorComponents = (CGFloat *)CGColorGetComponents(startColor.CGColor);
    
    CGFloat *endColorComponents = (CGFloat *)CGColorGetComponents(endColor.CGColor);
    
    CGFloat colorComponents[8] = {
        startColorComponents[0],
        startColorComponents[1],
        startColorComponents[2],
        startColorComponents[3],
        
        endColorComponents[0],
        endColorComponents[1],
        endColorComponents[2],
        endColorComponents[3]
    };
    
    CGFloat colorIndices[2] = {
        0.0f,1.0f
    };
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, (const CGFloat*)colorComponents, (const CGFloat*)colorIndices, 2);
    
    CGColorSpaceRelease(colorSpace);
    
    CGPoint startPoint = CGPointMake(0, CGRectGetMidY(rectArea));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(rectArea),CGRectGetMidY(rectArea));
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGGradientRelease(gradient);
    return theImage;
}


-(BOOL)uv_saveToPng:(NSURL*)url_
{
    NSData *imageData = UIImagePNGRepresentation(self);
    
    BOOL result = [imageData writeToURL:url_ atomically:YES];
    return result;
}

- (UIImage*)uv_imageWithRemoteUrl:(NSString*)url_
{
    if(url_.length < 1)
    {
        @throw [UVError errorWithCodeAndMessage:UV_GENERAL_ERROR_CODE message:@""];
    }


    NSArray *paths =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true);
    NSString *path = paths[0];
    path = [path stringByAppendingPathComponent:@"images"];
    NSFileManager *f = [NSFileManager defaultManager];
    if(![f fileExistsAtPath:path])
    {
        [f createDirectoryAtPath:path withIntermediateDirectories:TRUE attributes:nil error:nil];
    }

    NSString *filename = [url_ uv_md5passwd];
    NSString *full = [path stringByAppendingPathComponent:filename];
    if(![f fileExistsAtPath:full])
    {
        

        UVHttpClient *http = [[UVHttpClient alloc] init];
        http.responseType = RESPONSE_TYPE_BYTES;
        NSError *error;
        NSData *data = [http get:[NSURL URLWithString:url_] error:&error];
        if(error != nil)
        {
            @throw [UVError errorWithNSError:error];
        }
        if(!data || data == nil)
        {
            @throw [UVError errorWithCodeAndMessage:UV_GENERAL_ERROR_CODE message:@""];
        }
        [data writeToFile:full atomically:YES];
    }
    NSData *data = [NSData dataWithContentsOfFile:full];
    if(data == nil)
    {
        @throw [UVError errorWithCodeAndMessage:UV_GENERAL_ERROR_CODE message:@""];
    }
    return [UIImage imageWithData:data];
}
- (void)uv_cleanCache:(NSString*)url_
{
    NSArray *paths =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true);
    NSString *path = paths[0];
    path = [path stringByAppendingPathComponent:@"images"];
    NSFileManager *f = [NSFileManager defaultManager];
    if(![f fileExistsAtPath:path])
    {
        [f createDirectoryAtPath:path withIntermediateDirectories:TRUE attributes:nil error:nil];
    }
    
    NSString *filename = [url_ uv_md5passwd];
    NSString *full = [path stringByAppendingPathComponent:filename];
    if(![f fileExistsAtPath:full])
    {
        NSError *error;
        [f removeItemAtPath:full error:&error];
    }
}

- (BOOL)uv_isCache:(NSString*)url_
{
    NSArray *paths =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true);
    NSString *path = paths[0];
    path = [path stringByAppendingPathComponent:@"images"];
    NSString *filename = [url_ uv_md5passwd];
    NSString *full = [path stringByAppendingPathComponent:filename];
    
    NSFileManager *f = [NSFileManager defaultManager];
    return [f fileExistsAtPath:full];
}

@end
