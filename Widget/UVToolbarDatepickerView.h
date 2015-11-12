//
//  UVToolbarDatepickerView.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/11/12.
//  Copyright © 2015年 Uniview. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  确认类型
 */
typedef NS_ENUM(NSInteger,UV_TOOLBAR_DATEPICKER_CLICK_TYPE) {
    /**
     *  点击了取消按钮
     */
    UV_TOOLBAR_DATEPICKER_CLICK_TYPE_CANCEL,
    /**
     *  点击了确认按钮
     */
    UV_TOOLBAR_DATEPICKER_CLICK_TYPE_SURE
};

@protocol UVToolbarDatepickerViewDelegate;
/**
 *  显示工具栏的 datepickerview  说明：toolbar 默认的高度是44.f  datepicker的高度为216.f
 *  使用方法 ：UVToolbarDatepickerView *view = [[UVToolbarDatepickerView alloc] initWithParentView:self.view]   因为高度是固定的，所以不需要指定frame
 */
@interface UVToolbarDatepickerView : UIView
@property (nonatomic,weak) id<UVToolbarDatepickerViewDelegate> delegate;
@property (nonatomic,strong,readonly) NSDate *selectDate;
@property (nonatomic,strong,readonly) UIToolbar *toolbar;
@property (nonatomic,strong,readonly) UIDatePicker *datepicker;


/**
 *  初始化到指定父视图
 *
 *  @param view_ 你视图
 *
 *  @return id self
 */
- (id)initWithParentView:(UIView*)view_;
/**
 *  从底向上显示
 */
- (void)show;
/**
 *  隐藏
 */
- (void)hide;
@end

@protocol UVToolbarDatepickerViewDelegate <NSObject>

/**
 *  当前选择的时间 如果type为UV_TOOLBAR_DATEPICKER_CLICK_TYPE_CANCEL 时间为nil
 *
 *  @param sender_ 当前视图
 *  @param type_   点击按钮
 *  @param date_   当前选择的时间 如果type为UV_TOOLBAR_DATEPICKER_CLICK_TYPE_CANCEL 时间为nil
 */
- (void)onToolbarDatepickerViewChange:(UIView*)sender_ type:(UV_TOOLBAR_DATEPICKER_CLICK_TYPE)type_ selectDate:(NSDate*)date_;

@end

