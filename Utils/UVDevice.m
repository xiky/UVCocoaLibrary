//
//  UVDevice.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/6/5.
//  Copyright (c) 2015年 Chenjiaxin. All rights reserved.
//

#import "UVDevice.h"
#import <ifaddrs.h>
#import <arpa/inet.h>


@implementation UVDevice

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

@end
