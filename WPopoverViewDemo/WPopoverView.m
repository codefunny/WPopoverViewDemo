//
//  WPopoverView.m
//  WPopoverViewDemo
//
//  Created by wenchao on 16/2/2.
//  Copyright © 2016年 wenchao. All rights reserved.
//

#import "WPopoverView.h"

#define DEGREES_TO_RADIANS(degrees) ((M_PI * degrees) / 180)

@interface WPopoverView () {
    BOOL _isShow;
    CGFloat _cornerRadius;
    
}

@property (nonatomic,strong) UIView     *popView;
@property (nonatomic,strong) UIView    *attatchView;

@property (nonatomic,assign) CGSize     arrowSize;
@property (nonatomic,assign) CGPoint    arrowPoint;

@property (nonatomic,assign) CGPoint    popViewCenter;

@end

@implementation WPopoverView

- (instancetype)initWithAttachView:(UIView *)attatchView {
    self = [super init];
    if (self) {
        [self loadContentView];
        
        self.attatchView = attatchView ;
        [self.popView addSubview:self.attatchView];
    }
    
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadContentView];
    }
    
    return self;
}

- (void)loadContentView {
    _isShow = NO;
    _cornerRadius = 3.;
    self.backgroundColor = [UIColor orangeColor];
    self.popoverContentSize = CGSizeMake(100, 200);
    self.popoverLayoutMargins = UIEdgeInsetsMake(5, 5, 5, 5);
    self.contentLayoutMargins = UIEdgeInsetsMake(5, 5, 5, 5);
    self.backgroundColor = [UIColor lightGrayColor];
    self.popoverArrowDirection = WPopoverArrowDirectionDown;
    self.arrowSize = CGSizeMake(10, 10);
    self.arrowPoint = CGPointMake(20, 0);
    
    [self addSubview:self.popView];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint current = [touch locationInView:self];
    if (!CGRectContainsPoint(self.popView.frame, current)) {
        [self hide];
    }
}

- (void)p_addToWindow {
    [self.window addSubview:self];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.window addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.window addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.window addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self.window addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
}

- (void)p_updateCustomConstraints {
    CGRect rect = [UIScreen mainScreen].bounds;
    CGFloat width = MIN(CGRectGetWidth(rect), CGRectGetHeight(rect));
    width = width * 0.5;
    
    self.popView.translatesAutoresizingMaskIntoConstraints = NO ;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.popView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.popoverContentSize.width]];
    
    if (CGRectIsNull(self.sourceRect)) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.popView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.popView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    } else {
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.popView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:(self.popViewCenter.x - rect.size.width/2.)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.popView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:(self.popViewCenter.y - rect.size.height/2.)]];
    }
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.popView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.popoverContentSize.height]];
}

- (void)p_updateTableViewConstraint {
    
    UIEdgeInsets edgeInset = self.contentLayoutMargins;
    if (self.popoverArrowDirection == WPopoverArrowDirectionUp) {
        edgeInset.top += self.arrowSize.height ;
    } else if(self.popoverArrowDirection == WPopoverArrowDirectionDown) {
        edgeInset.bottom += self.arrowSize.height ;
    } else if(self.popoverArrowDirection == WPopoverArrowDirectionLeft) {
        edgeInset.left += self.arrowSize.width ;
    } else {
        edgeInset.right += self.arrowSize.width ;
    }
    
    self.attatchView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.popView addConstraint:[NSLayoutConstraint constraintWithItem:self.attatchView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.popView attribute:NSLayoutAttributeTop multiplier:1 constant:edgeInset.top]];
    [self.popView addConstraint:[NSLayoutConstraint constraintWithItem:self.attatchView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.popView attribute:NSLayoutAttributeLeft multiplier:1 constant:edgeInset.left]];
    [self.popView addConstraint:[NSLayoutConstraint constraintWithItem:self.attatchView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.popView attribute:NSLayoutAttributeBottom multiplier:1 constant:-edgeInset.bottom]];
    [self.popView addConstraint:[NSLayoutConstraint constraintWithItem:self.attatchView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.popView attribute:NSLayoutAttributeRight multiplier:1 constant:-edgeInset.right]];
}

#pragma mark - animations
- (void)applayAnimationAlertIn:(UIView *)view {
    [self layoutIfNeeded];
    CGRect originFrame = view.frame ;
    CGRect newFrame= originFrame;
    newFrame.size.height = 1 ;
    view.frame = newFrame ;
    view.alpha = 0;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        view.frame = originFrame ;
        view.alpha = 1.;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)applayAnimationAlertOut:(UIView *)view {
    CGRect originFrame = view.frame ;
    CGRect newFrame= originFrame;
    newFrame.size.height = 1 ;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        view.frame = newFrame;
        view.alpha = 0;
        
    } completion:^(BOOL finished) {
        view.frame = originFrame;
        [self removeFromSuperview];
    }];
}

- (void)applayAnimationArrowDownIn:(UIView *)view {
    [self layoutIfNeeded];
    CGRect originFrame = view.frame ;
    CGRect newFrame= originFrame;
    newFrame.origin.y += newFrame.size.height;
    newFrame.size.height = 1 ;
    view.frame = newFrame ;
    view.alpha = 0;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        view.frame = originFrame ;
        view.alpha = 1.;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)applayAnimationArrowDownOut:(UIView *)view {
    CGRect originFrame = view.frame ;
    CGRect newFrame= originFrame;
    newFrame.origin.y += newFrame.size.height;
    newFrame.size.height = 1 ;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        view.frame = newFrame;
        view.alpha = 0;
        
    } completion:^(BOOL finished) {
        view.frame = originFrame;
        [self removeFromSuperview];
    }];
}

- (void)applayAnimationArrowLeftIn:(UIView *)view {
    [self layoutIfNeeded];
    CGRect originFrame = view.frame ;
    CGRect newFrame= originFrame;
    newFrame.size.width = 1 ;
    view.frame = newFrame ;
    view.alpha = 0;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        view.frame = originFrame ;
        view.alpha = 1.;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)applayAnimationArrowLeftOut:(UIView *)view {
    CGRect originFrame = view.frame ;
    CGRect newFrame= originFrame;
    newFrame.size.width = 1 ;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        view.frame = newFrame;
        view.alpha = 0;
        
    } completion:^(BOOL finished) {
        view.frame = originFrame;
        [self removeFromSuperview];
    }];
}

- (void)applayAnimationArrowRightIn:(UIView *)view {
    [self layoutIfNeeded];
    CGRect originFrame = view.frame ;
    CGRect newFrame= originFrame;
    newFrame.origin.x += newFrame.size.width;
    newFrame.size.width = 1 ;
    view.frame = newFrame ;
    view.alpha = 0;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        view.frame = originFrame ;
        view.alpha = 1.;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)applayAnimationArrowRightOut:(UIView *)view {
    CGRect originFrame = view.frame ;
    CGRect newFrame= originFrame;
    newFrame.origin.x += newFrame.size.width;
    newFrame.size.width = 1 ;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        view.frame = newFrame;
        view.alpha = 0;
        
    } completion:^(BOOL finished) {
        view.frame = originFrame;
        [self removeFromSuperview];
    }];
}

#pragma mark public

- (void)show {
    if (_isShow) {
        return ;
    }
    _isShow = YES ;
    self.popView.backgroundColor = self.backgroundColor;
    [self calculatePosition];
    [self p_updateCustomConstraints];
    [self p_updateTableViewConstraint];
    [self p_addToWindow];
    [self triangForView:self.popView];
    
    if (self.popoverArrowDirection == WPopoverArrowDirectionUp) {
        [self applayAnimationAlertIn:self.popView];
    } else if (self.popoverArrowDirection == WPopoverArrowDirectionDown) {
        [self applayAnimationArrowDownIn:self.popView];
    } else if (self.popoverArrowDirection == WPopoverArrowDirectionLeft) {
        [self applayAnimationArrowLeftIn:self.popView];
    } else {
        [self applayAnimationArrowRightIn:self.popView];
    }
}

- (void)hide {
    if (!_isShow) {
        return ;
    }
    
    if (self.popoverArrowDirection == WPopoverArrowDirectionUp) {
        [self applayAnimationAlertOut:self.popView];
    } else if (self.popoverArrowDirection == WPopoverArrowDirectionDown) {
        [self applayAnimationArrowDownOut:self.popView];
    } else if (self.popoverArrowDirection == WPopoverArrowDirectionLeft) {
        [self applayAnimationArrowLeftOut:self.popView];
    } else {
        [self applayAnimationArrowRightOut:self.popView];
    }
    
    _isShow = NO;
}

#pragma mark getter
- (UIView *)popView {
    if (!_popView) {
        _popView = [[UIView alloc] init];
        _popView.layer.cornerRadius = 3.f;
        _popView.layer.masksToBounds = YES;
    }
    
    return _popView;
}

- (UIWindow *)window {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    return window;
}

#pragma mark utils

- (void)calculatePosition {
    CGRect sRect = self.sourceRect ;
    UIEdgeInsets margins = self.popoverLayoutMargins ;
    CGSize contentSize = self.popoverContentSize;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    if (contentSize.width > screenSize.width*0.9) {
        contentSize.width = screenSize.width * 0.9;
    }
    
    if (contentSize.height > screenSize.height * 0.8) {
        contentSize.height = screenSize.height * 0.8 ;
    }
    CGFloat centerX = CGRectGetMidX(self.sourceRect);
    CGFloat positionX = centerX ;
    if (contentSize.width /2. + centerX > screenSize.width) {
        positionX -= (contentSize.width/2. + centerX - screenSize.width + margins.right);
    }
    
    if (centerX - contentSize.width/2. < 0) {
        positionX += (contentSize.width/2. - centerX + margins.left);
    }
    
    CGFloat centerY = CGRectGetMidY(self.sourceRect);
    CGFloat positionY = centerY;
    if (centerY + contentSize.height / 2. > screenSize.height) {
        positionY -= (centerY + contentSize.height/2. - screenSize.height + margins.bottom);
    }
    
    if (centerY - contentSize.height/2. < 0) {
        positionY += (contentSize.height/2. - centerY + margins.top) ;
    }

    if (self.popoverArrowDirection == WPopoverArrowDirectionUp) {
        self.popViewCenter = (CGPoint){ positionX,(CGRectGetMaxY(sRect) + contentSize.height/2.)};
        self.arrowPoint = (CGPoint){contentSize.width/2. + (CGRectGetMidX(sRect) - positionX) , 0};
    } else if (self.popoverArrowDirection == WPopoverArrowDirectionDown) {
        self.popViewCenter = (CGPoint){ positionX,(CGRectGetMinY(sRect) - contentSize.height/2.)};
        self.arrowPoint = (CGPoint){contentSize.width/2. + (CGRectGetMidX(sRect) - positionX) , 0};
    } else if (self.popoverArrowDirection == WPopoverArrowDirectionLeft) {
        self.popViewCenter = (CGPoint){ CGRectGetMaxX(sRect) + contentSize.width/2.,positionY};
        self.arrowPoint = (CGPoint){0, contentSize.height/2. + (CGRectGetMidY(sRect) - positionY)};
    } else {
        self.popViewCenter = (CGPoint){ CGRectGetMinX(sRect) - contentSize.width/2.,positionY};
        self.arrowPoint = (CGPoint){0, contentSize.height/2. + (CGRectGetMidY(sRect) - positionY)};
    }
}

- (void)triangForView:(UIView *)view {
    UIBezierPath *bezierPath = nil;
    if (self.popoverArrowDirection == WPopoverArrowDirectionUp) {
        bezierPath = [self buildBackViewPathArrowUp];
    } else if(self.popoverArrowDirection == WPopoverArrowDirectionDown ) {
        bezierPath = [self buildBackViewPathArrowDown];
    } else if (self.popoverArrowDirection == WPopoverArrowDirectionLeft) {
        bezierPath = [self buildBackViewPathArrowLeft];
    } else {
        bezierPath = [self buildBackViewPathArrowRight];
    }
    
    CAShapeLayer* maskLayer = [CAShapeLayer layer];
    maskLayer.path = bezierPath.CGPath;
    maskLayer.fillColor = self.backgroundColor.CGColor;
    maskLayer.lineCap = kCALineCapRound;
    maskLayer.lineJoin = kCALineJoinRound;
    maskLayer.lineWidth = 1.f;
    view.layer.mask = maskLayer;
    view.layer.masksToBounds = YES;
}

- (UIBezierPath *)buildBackViewPathArrowUp {
    UIBezierPath *arrow = [UIBezierPath bezierPath];
    
    CGPoint arrowPoint = self.arrowPoint;
    CGSize arrowSize = self.arrowSize;
    CGFloat cornerRadius = _cornerRadius;
    CGFloat lineWidth = 1.;
    CGSize size = self.popView.bounds.size;
    
    [arrow moveToPoint:CGPointMake(arrowPoint.x, lineWidth/2.)];
    [arrow addLineToPoint:CGPointMake(arrowPoint.x + arrowSize.width * 0.5, arrowSize.height)];
    [arrow addLineToPoint:CGPointMake(size.width - cornerRadius, arrowSize.height)];
    [arrow addArcWithCenter:CGPointMake(size.width - cornerRadius,
                                        arrowSize.height + cornerRadius - lineWidth/2.)
                     radius:cornerRadius - lineWidth/2.
                 startAngle:DEGREES_TO_RADIANS(270.0)
                   endAngle:DEGREES_TO_RADIANS(0)
                  clockwise:YES];
    [arrow addLineToPoint:CGPointMake(size.width - lineWidth/2., size.height - cornerRadius)];
    [arrow
     addArcWithCenter:CGPointMake(size.width - cornerRadius, size.height - cornerRadius)
     radius:cornerRadius - lineWidth/2.
     startAngle:DEGREES_TO_RADIANS(0)
     endAngle:DEGREES_TO_RADIANS(90.0)
     clockwise:YES];
    [arrow addLineToPoint:CGPointMake(cornerRadius, size.height - lineWidth/2.)];
    [arrow addArcWithCenter:CGPointMake(cornerRadius, size.height - cornerRadius)
                     radius:cornerRadius - lineWidth/2.
                 startAngle:DEGREES_TO_RADIANS(90)
                   endAngle:DEGREES_TO_RADIANS(180.0)
                  clockwise:YES];
    [arrow addLineToPoint:CGPointMake(lineWidth/2., arrowSize.height + cornerRadius)];
    [arrow addArcWithCenter:CGPointMake(cornerRadius, arrowSize.height + cornerRadius - lineWidth/2.)
                     radius:cornerRadius - lineWidth/2.
                 startAngle:DEGREES_TO_RADIANS(180.0)
                   endAngle:DEGREES_TO_RADIANS(270)
                  clockwise:YES];
    [arrow
     addLineToPoint:CGPointMake(arrowPoint.x - arrowSize.width * 0.5, arrowSize.height)];
    [arrow closePath];
    
    return arrow;
}

- (UIBezierPath *)buildBackViewPathArrowDown {
    UIBezierPath *arrow = [UIBezierPath bezierPath];
    
    CGPoint arrowPoint = self.arrowPoint;
    CGSize arrowSize = self.arrowSize;
    CGFloat cornerRadius = _cornerRadius;
    CGFloat lineWidth = 1.;
    CGSize size = self.popView.bounds.size;
    
    [arrow moveToPoint:CGPointMake(arrowPoint.x, size.height - lineWidth/2.)];
    [arrow addLineToPoint:CGPointMake(arrowPoint.x + arrowSize.width * 0.5,  size.height - arrowSize.height)];
    [arrow addLineToPoint:CGPointMake(size.width - cornerRadius, size.height - arrowSize.height)];
    [arrow addArcWithCenter:CGPointMake(size.width - cornerRadius,
                                        size.height - arrowSize.height - cornerRadius + lineWidth/2.)
                     radius:cornerRadius - lineWidth/2.
                 startAngle:DEGREES_TO_RADIANS(270)
                   endAngle:DEGREES_TO_RADIANS(0)
                  clockwise:NO];
    [arrow addLineToPoint:CGPointMake(size.width - lineWidth/2., cornerRadius)];
    [arrow
     addArcWithCenter:CGPointMake(size.width - cornerRadius, cornerRadius)
     radius:cornerRadius - lineWidth/2.
     startAngle:DEGREES_TO_RADIANS(0)
     endAngle:DEGREES_TO_RADIANS(270)
     clockwise:NO];
    [arrow addLineToPoint:CGPointMake(cornerRadius, lineWidth/2.)];
    [arrow addArcWithCenter:CGPointMake(cornerRadius, cornerRadius)
                     radius:cornerRadius - lineWidth/2.
                 startAngle:DEGREES_TO_RADIANS(90)
                   endAngle:DEGREES_TO_RADIANS(180.0)
                  clockwise:NO];
    [arrow addLineToPoint:CGPointMake(lineWidth/2., size.height - arrowSize.height - cornerRadius)];
    [arrow addArcWithCenter:CGPointMake(cornerRadius, size.height - arrowSize.height - cornerRadius + lineWidth/2.)
                     radius:cornerRadius - lineWidth/2.
                 startAngle:DEGREES_TO_RADIANS(180.0)
                   endAngle:DEGREES_TO_RADIANS(90)
                  clockwise:NO];
    [arrow
     addLineToPoint:CGPointMake(arrowPoint.x - arrowSize.width * 0.5,size.height - arrowSize.height)];
    [arrow closePath];
    
    return arrow;
}

- (UIBezierPath *)buildBackViewPathArrowLeft {
    UIBezierPath *arrow = [UIBezierPath bezierPath];
    
    CGPoint arrowPoint = self.arrowPoint;
    CGSize arrowSize = self.arrowSize;
    CGFloat cornerRadius = _cornerRadius;
    CGFloat lineWidth = 1.;
    CGSize size = self.popView.bounds.size;
    
    [arrow moveToPoint:CGPointMake(lineWidth/2., arrowPoint.y)];
    [arrow addLineToPoint:CGPointMake(arrowSize.width, arrowPoint.y + arrowSize.height * 0.5 )];
    [arrow addLineToPoint:CGPointMake(arrowSize.width + lineWidth/2., size.height - cornerRadius)];
    [arrow addArcWithCenter:CGPointMake(arrowSize.width + cornerRadius,
                                        size.height - cornerRadius + lineWidth/2.)
                     radius:cornerRadius - lineWidth/2.
                 startAngle:DEGREES_TO_RADIANS(0)
                   endAngle:DEGREES_TO_RADIANS(90)
                  clockwise:NO];
    [arrow addLineToPoint:CGPointMake(size.width - cornerRadius, size.height)];
    [arrow
     addArcWithCenter:CGPointMake(size.width - cornerRadius,size.height - cornerRadius)
     radius:cornerRadius - lineWidth/2.
     startAngle:DEGREES_TO_RADIANS(270)
     endAngle:DEGREES_TO_RADIANS(0)
     clockwise:NO];
    [arrow addLineToPoint:CGPointMake(size.width - lineWidth/2., cornerRadius)];
    [arrow addArcWithCenter:CGPointMake(size.width - cornerRadius, cornerRadius)
                     radius:cornerRadius - lineWidth/2.
                 startAngle:DEGREES_TO_RADIANS(180)
                   endAngle:DEGREES_TO_RADIANS(270.0)
                  clockwise:NO];
    [arrow addLineToPoint:CGPointMake(arrowSize.width + cornerRadius, lineWidth/2.)];
    [arrow addArcWithCenter:CGPointMake(arrowSize.width + cornerRadius, cornerRadius)
                     radius:cornerRadius - lineWidth/2.
                 startAngle:DEGREES_TO_RADIANS(90.0)
                   endAngle:DEGREES_TO_RADIANS(180)
                  clockwise:NO];
    [arrow
     addLineToPoint:CGPointMake(arrowSize.width, arrowPoint.y - arrowSize.height/2.)];
    [arrow closePath];
    
    return arrow;
}

- (UIBezierPath *)buildBackViewPathArrowRight {
    UIBezierPath *arrow = [UIBezierPath bezierPath];
    
    CGPoint arrowPoint = self.arrowPoint;
    CGSize arrowSize = self.arrowSize;
    CGFloat cornerRadius = _cornerRadius;
    CGFloat lineWidth = 1.;
    CGSize size = self.popView.bounds.size;
    
    [arrow moveToPoint:CGPointMake(size.width - lineWidth/2.,arrowPoint.y)];
    [arrow addLineToPoint:CGPointMake(size.width - arrowSize.width, arrowPoint.y - arrowSize.height * 0.5)];
    [arrow addLineToPoint:CGPointMake(size.width - arrowSize.width, cornerRadius)];
    [arrow addArcWithCenter:CGPointMake(size.width - arrowSize.width - cornerRadius + lineWidth/2.,cornerRadius)
                     radius:cornerRadius - lineWidth/2.
                 startAngle:DEGREES_TO_RADIANS(180)
                   endAngle:DEGREES_TO_RADIANS(270)
                  clockwise:NO];
    [arrow addLineToPoint:CGPointMake(cornerRadius, lineWidth/2.)];
    [arrow
     addArcWithCenter:CGPointMake(cornerRadius, cornerRadius - lineWidth/2.)
     radius:cornerRadius - lineWidth/2.
     startAngle:DEGREES_TO_RADIANS(90)
     endAngle:DEGREES_TO_RADIANS(180)
     clockwise:NO];
    [arrow addLineToPoint:CGPointMake(lineWidth/2.,size.height - cornerRadius - lineWidth/2.)];
    [arrow addArcWithCenter:CGPointMake(cornerRadius, size.height - cornerRadius)
                     radius:cornerRadius - lineWidth/2.
                 startAngle:DEGREES_TO_RADIANS(0)
                   endAngle:DEGREES_TO_RADIANS(90.0)
                  clockwise:NO];
    [arrow addLineToPoint:CGPointMake(size.width -arrowSize.width - cornerRadius,size.height - lineWidth/2.)];
    [arrow addArcWithCenter:CGPointMake(size.width - arrowSize.width - cornerRadius, size.height - cornerRadius + lineWidth/2.)
                     radius:cornerRadius - lineWidth/2.
                 startAngle:DEGREES_TO_RADIANS(90)
                   endAngle:DEGREES_TO_RADIANS(0)
                  clockwise:NO];
    [arrow
     addLineToPoint:CGPointMake(size.width - arrowSize.width,arrowPoint.y + arrowSize.width * 0.5)];
    [arrow closePath];
    
    return arrow;
}

@end
