//
//  NSString+UVUtils.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/8/26.
//  Copyright (c) 2015年 Uniview. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface NSString (UVUtils)


- (BOOL)matchByRegpx:(NSString*)reg_;

/** 返回md5加密串
 
 @param NSString 要加密的明文串
 @return NSString 返回加密后的32位md5密文
 */
- (NSString *)md5passwd;

/**
 */
- (NSString*)sha256passwd;

- (CGSize)sizeByFont:(UIFont*)font_ maxSize:(CGSize)size_;
@end
