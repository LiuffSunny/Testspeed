//
//  UIView+Addition.m
//  SP2P_6.1
//
//  Created by jun on 15/5/14.
//  Copyright (c) 2015年 EIMS. All rights reserved.
//

#import "UIview+Addition.h"

@implementation UIView (Addition)

- (void)setViewX:(CGFloat)x
{
    CGRect rect = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
}

- (void)setViewY:(CGFloat)y
{
    CGRect rect = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
}

- (void)setViewWidth:(CGFloat)width
{
    CGRect rect = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
    self.frame = rect;
}
- (void)setViewHeight:(CGFloat)height
{
    CGRect rect = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    self.frame = rect;
}

- (void)setViewOrigin:(CGPoint)origin
{
    CGRect rect = CGRectMake(origin.x, origin.y, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
}

- (void)removeAllSubViews
{
    for (UIView *subView in self.subviews)
    {
        [subView removeFromSuperview];
    }
}

- (CGFloat)X
{
    return self.frame.origin.x;
}
- (CGFloat)Y
{
    return self.frame.origin.y;
}
- (CGFloat)Width
{
     return self.frame.size.width;
}
- (CGFloat)Height
{
    return self.frame.size.height;
}


- (CGFloat)XMax
{
    return self.frame.origin.x + self.frame.size.width;
}
- (CGFloat)YMax{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setCentX:(CGFloat)x
{
    self.center =  CGPointMake(x, self.center.y);
}

- (void)setCentY:(CGFloat)y
{
    self.center =  CGPointMake(self.center.x, y);
}

// 动态展示提示View
- (void)animationAlert {
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.layer addAnimation:popAnimation forKey:nil];
    
}
@end
