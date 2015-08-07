//
//  UIImage+Utils.h
//  br_AirimosPhone_report
//
//  Created by chenjiaxin on 10/11/13.
//  Copyright (c) 2013 XXXX. All rights reserved.
//
/**
 * 图像操作增强工具类
 */
#import <UIKit/UIKit.h>
@class UVError;

@interface UIImage (Utils)

/**
 * 使用颜色创建一个新的图像
 * @param UIColor 指定要使用的颜色
 * @return UIImage 新图像
 */
+ (UIImage *) createImageWithColor: (UIColor *) color;
/**
 * 使用尺寸和起始颜色创建一个新的图像
 * @param CGRect rectArea 图像大小
 * @param UIColor startcolor 开始颜色
 * @praam UIColor endcolor 结束颜色
 */
+ (UIImage *) createImageWithGradient:(CGRect)rectArea colorStart:(UIColor*) startColor colorEnd:(UIColor*)endColor;

/**
 * 在当前图像中加入文字
 * @param NSString text_ 要增加的文字 
 * @param UIFont font_ 文字的字体 不指定将默认为18号字体
 * @param CGRect rect_ 增加文字的位置 不指定默为左上解自适应文字长度
 * @return UIImage 增加文字后的新图像
 */
-(UIImage*)writeText:(NSString*)text_ font:(UIFont*)font_ rect:(CGRect)rect_;
-(UIImage*)writeText:(NSString*)text_;
-(UIImage*)writeText:(NSString*)text_ font:(UIFont*)font_;

/**
 * 将当图像缩放到指定大小
 * @param CGSize 要缩放的大小
 * @return UIImage 缩放后的新图像
 */
- (UIImage *)scaleToSize:(CGSize)size;

/**
 * 将当前图像作为Jpg图像存储到本地
 * @param NSURL 要存储到本地的位置
 * @return BOOL YES表示操作成功
 */
-(BOOL)saveToJpg:(NSURL*)url_;
/**
 * 将当前图片存入到相集中
 */
-(void)saveToPhotoAlbum:(void (^)(NSURL *assetURL,UVError *error))finish_;

-(BOOL)saveToPng:(NSURL*)url_;

- (UIImage *)tintedImageWithColor:(UIColor *)tintColor;
- (UIImage *)tintedGradientImageWithColor:(UIColor *)tintColor;

@end
