//
//  UITextField+Shake.m
//  UITextField+Shake
//
//  Created by Andrea Mazzini on 08/02/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "UIView+Shake.h"

@implementation UIView (Shake)

- (void)uv_shake:(int)times withDelta:(CGFloat)delta finish:(void (^)())finish_
{
	[self _uv_shake:times direction:1 currentTimes:0 withDelta:delta andSpeed:0.03 shakeDirection:UV_SHAKE_DIRECTION_HORIZONTAL finish:finish_];
}

- (void)uv_shake:(int)times withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval finish:(void (^)())finish_
{
	[self _uv_shake:times direction:1 currentTimes:0 withDelta:delta andSpeed:interval shakeDirection:UV_SHAKE_DIRECTION_HORIZONTAL finish:finish_];
}

- (void)uv_shake:(int)times withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval shakeDirection:(UV_SHAKE_DIRECTION)shakeDirection finish:(void (^)())finish_
{
    [self _uv_shake:times direction:1 currentTimes:0 withDelta:delta andSpeed:interval shakeDirection:shakeDirection finish:finish_];
}

- (void)_uv_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval shakeDirection:(UV_SHAKE_DIRECTION)shakeDirection finish:(void (^)())finish_
{
	[UIView animateWithDuration:interval animations:^{
		self.transform = (shakeDirection == UV_SHAKE_DIRECTION_HORIZONTAL) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
	} completion:^(BOOL finished) {
		if(current >= times)
        {
			self.transform = CGAffineTransformIdentity;
            if(finish_ != nil)
            {
                finish_();
            }
			return;
		}
		[self _uv_shake:(times - 1)
		   direction:direction * -1
		currentTimes:current + 1
		   withDelta:delta
			andSpeed:interval
         shakeDirection:shakeDirection finish:finish_];
	}];
}

@end
