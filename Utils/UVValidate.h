//
//  UVValidate.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/8/26.
//  Copyright (c) 2015年 Uniview. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UVValidate : NSObject

- (BOOL)require:(NSString*)str_;
- (BOOL)mobile:(NSString*)str_;
- (BOOL)email:(NSString*)str_;
- (BOOL)phone:(NSString*)str_;
- (BOOL)url:(NSString*)str_;
- (BOOL)number:(NSString*)str_;
- (BOOL)zip:(NSString*)str_;
- (BOOL)qq:(NSString*)str_;
- (BOOL)integer:(NSString*)str_;
- (BOOL)isDouble:(NSString*)str_;
- (BOOL)english:(NSString*)str_;
- (BOOL)chinese:(NSString*)str_;
- (BOOL)username:(NSString*)str_;
- (BOOL)unsafe:(NSString*)str_;
- (BOOL)limit:(NSString*)str_ min:(NSInteger)min_ max:(NSInteger)max_;
- (BOOL)range:(NSString*)str_ min:(NSInteger)min_ max:(NSInteger)max_;
- (BOOL)custom:(NSString *)str_ repx:(NSString*)repx_;
@end
