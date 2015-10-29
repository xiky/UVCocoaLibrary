//
//  YKModelView.h
//  YKActionSheet.h YKActionSheet
//
//  Created by chenjiaxin on 15/10/29.
//  Copyright © 2015年 chenjiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UVModelViewDelegate;

@interface UVModelView : UIView
@property (nonatomic,weak) id<UVModelViewDelegate> delegate;
@property(nonatomic,strong,readonly) UIView *childView;
@property(nonatomic,assign,readonly) BOOL isShow;
@property(nonatomic,assign) BOOL autoHidden;

- (id)initWithChildView:(UIView*)view_;

- (void)showInSupperView:(UIView*)view_;
- (void)hide;
@end

@protocol UVModelViewDelegate <NSObject>

@optional
- (void)onUVModelViewHide:(UVModelView*)view_;
@end
