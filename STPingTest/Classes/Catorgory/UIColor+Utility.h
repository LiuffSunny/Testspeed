//
//  UIColor+Utility.h
//  MDoctor
//
//  Created by Bill on 7/9/15.
//  Copyright (c) 2015 MDoctor. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIColor (Utility)

+ (UIColor *)themeNaviBarColor;
+ (UIColor *)themeBackgroundColor;

/**
 *  背景色
 *
 *  @return 0xf9f9f9
 */
+ (UIColor *)backgroundColor;

/**
 *  深背景色
 *
 *  @return 0xe0e0e0
 */
+ (UIColor *)darkBackgroundColor;

/**
 *  浅字体色
 *
 *  @return 0x999999
 */
+ (UIColor *)lightTextColor;

/**
 *  字体色
 *
 *  @return 0x666666
 */
+ (UIColor *)textColor;

/**
 *  深字体色
 *
 *  @return 0x333333
 */
+ (UIColor *)darkTextColor;

/**
 *  线颜色
 *
 *  @return 0xf2f6f0
 */
+ (UIColor *)lineColor;

/**
 *  深线颜色
 *
 *  @return 0xdddddd
 */
+ (UIColor *)darklineColor;
/**
 *  浅色分割线颜色
 *
 *  @return 0xe9e9e9
 */
+ (UIColor *)lightDarklineColor;
/**
 *  蓝色
 *
 *  @return 0x54c7e6
 */
+ (UIColor *)BlueColor;

/**
 *  深绿
 *
 *  @return 0x80b62b
 */
+ (UIColor *)darkGreenColor;

/**
 *  浅绿
 *
 *  @return 0xadca2d
 */
+ (UIColor *)lightGreenColor;

/**
 *  橙色
 *
 *  @return 0xf7941d
 */
+ (UIColor *)OrangeColor;

/**
 *  主色调
 *
 *  @return 0xf7941d
 */
+ (UIColor *)MainColor;

+ (UIColor *)lightMainColor;
+ (UIColor *)brightMainColor;
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha;

@end
