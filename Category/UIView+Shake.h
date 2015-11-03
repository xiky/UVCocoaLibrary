//
//  UITextField+Shake.h
//  UITextField+Shake
//  功能：指定视图进行左右或上下抖动
//  Created by Andrea Mazzini on 08/02/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UV_SHAKE_DIRECTION) {
    UV_SHAKE_DIRECTION_HORIZONTAL= 0,
    UV_SHAKE_DIRECTION_VERTICAL
};

@interface UIView (Shake)

/**-----------------------------------------------------------------------------
 * @name UITextField+Shake
 * -----------------------------------------------------------------------------
 */

/** Shake the UITextField
*
* Shake the text field a given number of times
*
* @param times The number of shakes
* @param delta The width of the shake
*/
- (void)uv_shake:(int)times withDelta:(CGFloat)delta finish:(void (^)())finish_;

/** Shake the UITextField at a custom speed
 *
 * Shake the text field a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 */
- (void)uv_shake:(int)times withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval finish:(void (^)())finish_;

/** Shake the UITextField at a custom speed
 *
 * Shake the text field a given number of times with a given speed
 *
 * @param times The number of shakes 抖动次数
 * @param delta The width of the shake 抖动幅度
 * @param interval The duration of one shake 每次抖动完成时间 如0.04
 * @param direction of the shake 抖动方向
 */
- (void)uv_shake:(int)times withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval shakeDirection:(UV_SHAKE_DIRECTION)shakeDirection finish:(void (^)())finish_;

@end
