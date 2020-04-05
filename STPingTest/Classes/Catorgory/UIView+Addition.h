//
//  UIView+Addition.h
//  SP2P_6.1
//
//  Created by jun on 15/5/14.
//  Copyright (c) 2015年 EIMS. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
/*
 *
 *  所有的缩放都是根据iPhone5的尺寸来的（320，568）,
 *
 */


@interface UIView (Addition)



//根据单个位置或者大小来适配
#define PERWIDTH(X)  X/320.0*SCREEN_WIDTH
#define PERHEIGHT(Y) Y *MAX(SCREEN_HEIGHT,568)/568.0

#define PERPhone6WIDTH(X)  X/375.0*SCREEN_WIDTH

CGFloat ZGetSizeLayout(CGFloat size);
/*
 *根据位置来自适应
 *只能用来初始化，不可用来重复设置坐标，那样放大倍数会重复叠加
 *
*/
CGRect ZRectMakeWithRect(CGRect f);

- (void)setViewX:(CGFloat)x;
- (void)setViewY:(CGFloat)y;
- (void)setViewWidth:(CGFloat)width;
- (void)setViewHeight:(CGFloat)height;
- (void)setViewOrigin:(CGPoint)origin;

- (CGFloat)X;
- (CGFloat)Y;
- (CGFloat)Width;
- (CGFloat)Height;
- (CGFloat)XMax;
- (CGFloat)YMax;



- (void)removeAllSubViews;

- (void)setCentX:(CGFloat)x;

- (void)setCentY:(CGFloat)y;

// 动态展示提示View
- (void)animationAlert;
@end
