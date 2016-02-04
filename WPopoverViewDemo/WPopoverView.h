//
//  WPopoverView.h
//  WPopoverViewDemo
//
//  Created by wenchao on 16/2/2.
//  Copyright © 2016年 wenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger,WPopoverArrowDirection) {
    WPopoverArrowDirectionUp = 1UL << 0,
    WPopoverArrowDirectionDown = 1UL << 1,
    WPopoverArrowDirectionLeft = 1UL << 2,
    WPopoverArrowDirectionRight = 1UL << 3,
};

@interface WPopoverView : UIView

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;

- (instancetype)initWithAttachView:(UIView *)attatchView;

@property (nonatomic) CGSize popoverContentSize;
@property (nonatomic, readonly, getter=isPopoverVisible) BOOL popoverVisible;

@property (nonatomic, assign) WPopoverArrowDirection popoverArrowDirection; //箭头方向 

@property (nullable, nonatomic, copy) UIColor *backgroundColor ;
@property (nonatomic, readwrite) UIEdgeInsets popoverLayoutMargins ;
@property (nonatomic, readwrite) UIEdgeInsets contentLayoutMargins ;

@property (nonatomic,assign) CGRect     sourceRect;

- (void) show;

- (void) hide;

@end

NS_ASSUME_NONNULL_END