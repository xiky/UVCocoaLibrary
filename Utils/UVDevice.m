//
//  UVDevice.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/6/5.
//  Copyright (c) 2015年 Chenjiaxin. All rights reserved.
//

#import "UVDevice.h"
#import "UVConest.h"
#import "UVHttpClient.h"
#import "UVRequest.h"
#include <netdb.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/utsname.h>


@implementation UVDevice
+(instancetype)shareInstance
{
    static dispatch_once_t predUVDevice = 0;
    static UVDevice *uvdeviceintance;
    dispatch_once(&predUVDevice, ^{
        uvdeviceintance = [[UVDevice alloc] init];
    });
    return uvdeviceintance;
}

/*
 {
 BuildMachineOSBuild = 14F27;
 CFBundleDevelopmentRegion = "zh_CN";
 CFBundleExecutable = ABC360;
 CFBundleIcons =     {
 CFBundlePrimaryIcon =         {
 CFBundleIconFiles =             (
 "AppIcon_new40x40",
 "AppIcon_new57x57",
 "AppIcon_new60x60",
 "AppIcon_new120x120"
 );
 };
 };
 CFBundleIdentifier = "com.abc360.ABC360";
 CFBundleInfoDictionaryVersion = "6.0";
 CFBundleInfoPlistURL = "Info.plist -- file:///private/var/mobile/Containers/Bundle/Application/6D9ED22B-FA53-4F36-85D7-40DA1F058B90/ABC360.app/";
 CFBundleName = ABC360;
 CFBundleNumericVersion = 268468224;
 CFBundlePackageType = APPL;
 CFBundleShortVersionString = "2.0";
 CFBundleSignature = "????";
 CFBundleSupportedPlatforms =     (
 iPhoneOS
 );
 CFBundleVersion = 10;
 DTCompiler = "com.apple.compilers.llvm.clang.1_0";
 DTPlatformBuild = 12H141;
 DTPlatformName = iphoneos;
 DTPlatformVersion = "8.4";
 DTSDKBuild = 12H141;
 DTSDKName = "iphoneos8.4";
 DTXcode = 0640;
 DTXcodeBuild = 6E35b;
 LSRequiresIPhoneOS = 1;
 MinimumOSVersion = "6.0";
 UIBackgroundModes =     (
 audio,
 fetch
 );
 UIDeviceFamily =     (
 1
 );
 UILaunchImages =     (
 {
 UILaunchImageMinimumOSVersion = "7.0";
 UILaunchImageName = "LaunchImage-700";
 UILaunchImageOrientation = Portrait;
 UILaunchImageSize = "{320, 480}";
 }
 );
 UILaunchStoryboardName = LaunchScreen;
 UIMainStoryboardFile = user;
 UIRequiredDeviceCapabilities =     (
 armv7
 );
 UIStatusBarStyle = UIStatusBarStyleLightContent;
 UISupportedInterfaceOrientations =     (
 UIInterfaceOrientationPortrait,
 UIInterfaceOrientationLandscapeLeft,
 UIInterfaceOrientationLandscapeRight
 );
 UIViewControllerBasedStatusBarAppearance = 0;
 }
 */

- (NSString*)appVersionName
{
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
 
    return info[@"CFBundleShortVersionString"];
    //NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
}
- (void)getAppStoreVersion:(NSString *)appId complete:(void (^)(BOOL))complete
{
    UVHttpClient *client = [UVHttpClient instance];
    UVRequest *request = [[UVRequest alloc] init];
    
    NSString *path = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/lookup?id=%@", appId];
    NSURL *url = [NSURL URLWithString:path];
    
    __block NSData *data = nil;
    [request exec:^{
        data = [client post:url param:nil error:nil];
    } finish:^(UVError *error) {
        if (data) {
            NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//            NSLog(@"receiveDic: %@", receiveDic);
            if ([[receiveDic valueForKey:@"resultCount"] intValue]>0) {
                NSString *appStore = [[[receiveDic valueForKey:@"results"] objectAtIndex:0] valueForKey:@"version"];
                complete([self compareVersion:appStore]);
            }
        }
    }];
}

- (BOOL)compareVersion:(NSString *)storeVersion {
    
    NSArray *storeVersionNumbers = [storeVersion componentsSeparatedByString:@"."];
    NSArray *localVersionNumbers = [[self appVersionName] componentsSeparatedByString:@"."];
    
    if (storeVersionNumbers.count != localVersionNumbers.count) {
        return NO;
    }
    
    for (int i = 0; i < storeVersionNumbers.count; i++) {
        NSInteger store = [[storeVersionNumbers objectAtIndex:i] integerValue];
        NSInteger local = [[localVersionNumbers objectAtIndex:i] integerValue];
        if (store > local) {
            return YES;
        }
    }
    
    return NO;
}

- (NSString*)appVersionCode
{
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;

    return info[@"CFBundleVersion"];
}
- (NSString *)bundleid
{
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    
    return info[@"CFBundleIdentifier"];
}

- (NSString *)getIPAddress
{
    NSString *address = @"";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

- (NSString *)getIPAddressForHost:(NSString *)theHost_
{
    struct hostent *host = gethostbyname([theHost_ UTF8String]);
    if (!host) {return nil; }
    struct in_addr **list = (struct in_addr **)host->h_addr_list;
    NSString *addressString = [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding];
    return addressString;
}

- (CGFloat)scaleWidth
{
    CGFloat scaleWidth = UV_SCREEN_WIDTH / 375.f;
    return scaleWidth;
}
- (CGFloat)scaleHeight
{
    CGFloat scaleheight = UV_SCREEN_HEIGHT / 667.f;
    return scaleheight;
}
- (BOOL) isIpad
{
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

- (BOOL) isIphone
{
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}

- (BOOL) isSimulator
{
    return [[self deviceName] isEqualToString:@"Simulator"];
}

- (NSString *) deviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * code = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    static NSDictionary* deviceNamesByCode = nil;
    if(!deviceNamesByCode)
    {
        deviceNamesByCode = @{
                              @"i386"      :@"Simulator",
                              @"x86_64"    :@"Simulator",
                              @"iPod1,1"   :@"iPod Touch",      // (Original)
                              @"iPod2,1"   :@"iPod Touch",      // (Second Generation)
                              @"iPod3,1"   :@"iPod Touch",      // (Third Generation)
                              @"iPod4,1"   :@"iPod Touch",      // (Fourth Generation)
                              @"iPhone1,1" :@"iPhone",          // (Original)
                              @"iPhone1,2" :@"iPhone",          // (3G)
                              @"iPhone2,1" :@"iPhone",          // (3GS)
                              @"iPad1,1"   :@"iPad",            // (Original)
                              @"iPad2,1"   :@"iPad 2",          //
                              @"iPad3,1"   :@"iPad",            // (3rd Generation)
                              @"iPhone3,1" :@"iPhone 4",        // (GSM)
                              @"iPhone3,3" :@"iPhone 4",        // (CDMA/Verizon/Sprint)
                              @"iPhone4,1" :@"iPhone 4S",       //
                              @"iPhone5,1" :@"iPhone 5",        // (model A1428, AT&T/Canada)
                              @"iPhone5,2" :@"iPhone 5",        // (model A1429, everything else)
                              @"iPad3,4"   :@"iPad",            // (4th Generation)
                              @"iPad2,5"   :@"iPad Mini",       // (Original)
                              @"iPhone5,3" :@"iPhone 5c",       // (model A1456, A1532 | GSM)
                              @"iPhone5,4" :@"iPhone 5c",       // (model A1507, A1516, A1526 (China), A1529 | Global)
                              @"iPhone6,1" :@"iPhone 5s",       // (model A1433, A1533 | GSM)
                              @"iPhone6,2" :@"iPhone 5s",       // (model A1457, A1518, A1528 (China), A1530 | Global)
                              @"iPhone7,1" :@"iPhone 6 Plus",   //
                              @"iPhone7,2" :@"iPhone 6",        //
                              @"iPad4,1"   :@"iPad Air",        // 5th Generation iPad (iPad Air) - Wifi
                              @"iPad4,2"   :@"iPad Air",        // 5th Generation iPad (iPad Air) - Cellular
                              @"iPad4,4"   :@"iPad Mini",       // (2nd Generation iPad Mini - Wifi)
                              @"iPad4,5"   :@"iPad Mini"        // (2nd Generation iPad Mini - Cellular)
                              };
    }
    
    NSString * deviceName = [deviceNamesByCode objectForKey:code];
    
    if(!deviceName)
    {
        // Not found on database. At least guess main device type from string contents:
        if([code rangeOfString:@"iPod"].location != NSNotFound)
        {
            deviceName = @"iPod Touch";
        }
        else if([code rangeOfString:@"iPad"].location != NSNotFound)
        {
            deviceName = @"iPad";
        }
        else if([code rangeOfString:@"iPhone"].location != NSNotFound)
        {
            deviceName = @"iPhone";
        }
    }
    
    return deviceName;
}

- (BOOL) isIphone4
{
    //if([self isSimulator])
    {
        CGRect bounds = [UIScreen mainScreen].bounds;
        if(bounds.size.width == 320 && bounds.size.height == 480)
        {
            return YES;
        }
        return NO;
    }
//    return [[self deviceName] isEqualToString:@"iPhone4"] || [[self deviceName] isEqualToString:@"iPhone 4S"];
}

- (BOOL) isIphone5
{
//    if([self isSimulator])
    {
        CGRect bounds = [UIScreen mainScreen].bounds;
        if(bounds.size.width == 640 && bounds.size.height == 1136)
        {
            return YES;
        }
        if(bounds.size.width == 320 && bounds.size.height == 568)
        {
            return YES;
        }
        return NO;
    }
//    return [[self deviceName] isEqualToString:@"iPhone5"] || [[self deviceName] isEqualToString:@"iPhone 5s"] || [[self deviceName] isEqualToString:@"iPhone 5c"];
}
- (BOOL)isIphone6
{
//    if([self isSimulator])
    {
        CGRect bounds = [UIScreen mainScreen].bounds;
        if(bounds.size.width == 750 && bounds.size.height == 1334)
        {
            return YES;
        }
        if(bounds.size.width == 375 && bounds.size.height == 667)
        {
            return YES;
        }
        return NO;
    }
//    return [[self deviceName] isEqualToString:@"iPhone6"];
}

- (BOOL)isIphone6p
{
//    if([self isSimulator])
    {
        CGRect bounds = [UIScreen mainScreen].bounds;
        if(bounds.size.width == 1242 && bounds.size.height == 2208)
        {
            return YES;
        }
        if(bounds.size.width == 414 && bounds.size.height == 736)
        {
            return YES;
        }
        return NO;
    }
//    return [[self deviceName] isEqualToString:@"iPhone 6 Plus"];
}
@end
