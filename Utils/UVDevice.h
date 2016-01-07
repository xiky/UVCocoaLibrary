//
//  UVDevice.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/6/5.
//  Copyright (c) 2015年 Chenjiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UVDevice : NSObject

+(instancetype)shareInstance;
/**
 *  当前APP的外部版本号
 *
 *  @return NSString
 */
- (NSString*)appVersionName;
/**
 *  获取App Store
 *
 *  @param appId AppId
 *
 *  @return 布尔值
 */
- (void)getAppStoreVersion:(NSString *)appId complete:(void (^)(BOOL))complete;
/**
 *  当前APP的内部版本号
 *
 *  @return NSString
 */
- (NSString*)appVersionCode;
/**
 *  当前APP的bundle id
 *
 *  @return NSString
 */
- (NSString *)bundleid;
/**
 *  当前设备IP地址
 *
 *  @return NSString
 */
- (NSString*)getIPAddress;

/**
 *  根据域名获取对方主机的IP
 *
 *  @param theHost 如 www.163.com
 *
 *  @return 获取失败返回 nil，否则返回真实的IP
 */
- (NSString *)getIPAddressForHost:(NSString *)theHost_;

/**
 *  基于iphone6屏幕尺寸缩放宽比例 由于iphone4和iphone5的宽是一样的。因此，高度比例主要参考scaleHeight
 *
 *  @return CGFloat
 */
- (CGFloat)scaleWidth;

/**
 *  基于iphone6屏幕尺寸缩放高比例
 *
 *  @return CGFloat
 */
- (CGFloat)scaleHeight;
/**
 *  当前设备是否为ipad
 *
 *  @return BOOL
 */
- (BOOL)isIpad;
/**
 *  当前设备是否为Iphone
 *
 *  @return BOOL
 */
- (BOOL)isIphone;
/**
 *  当前设备是滞为模拟器
 *
 *  @return BOOL
 */
- (BOOL)isSimulator;
/**
 *  当前设备是否为iphone4
 *
 *  @return BOOL
 */
- (BOOL)isIphone4;
/**
 *  当前设备类型
 *
 *  @return NSString
 */
- (NSString*)deviceName;
/**
 *  当前设备是否为Iphone5
 *
 *  @return BOOL
 */
- (BOOL)isIphone5;
/**
 *  当前设备是否为iphone6
 *
 *  @return BOOL
 */
- (BOOL)isIphone6;
/**
 *  当前设备是否为iphone6p
 *
 *  @return BOOL
 */
- (BOOL)isIphone6p;
@end
