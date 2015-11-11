//
//  UVFileManage.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/11/10.
//  Copyright © 2015年 Uniview. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UVFileManage : NSObject

/**
 *  验证本地文件是否有效
 *
 *  @param full_ 文件详细路径
 *  @param size_ 文件真实大小
 *
 *  @return BOOL
 */
- (BOOL)valid:(NSString*)full_ realSize:(float)size_;
@end
