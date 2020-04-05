//
//  UIColor+Utility.m
//  MDoctor
//
//  Created by Bill on 7/9/15.
//  Copyright (c) 2015 MDoctor. All rights reserved.
//

#import "UIColor+Utility.h"

@implementation UIColor (Utility)

+ (UIColor *)themeNaviBarColor
{
    return [UIColor whiteColor];
}

+ (UIColor *)themeBackgroundColor
{
    return [UIColor lightGrayColor];
}

+ (UIColor *)backgroundColor{
    
    return [UIColor colorWithHex:0xf8f8f8 alpha:1];
}

+ (UIColor *)darkBackgroundColor{
    return [UIColor colorWithHex:0xe0e0e0 alpha:1];
}


+ (UIColor *)textColor{
    
    return [UIColor colorWithHex:0x666666 alpha:1];
}

+ (UIColor *)darkTextColor{
    
    return [UIColor colorWithHex:0x333333 alpha:1];
}

+ (UIColor *)lineColor{
    //e7e7e7
    return [UIColor colorWithHex:0xf2f6f0 alpha:1];
}

+ (UIColor *)darklineColor{
    //e7e7e7
    return [UIColor colorWithHex:0xdddddd alpha:1];
}
+ (UIColor *)lightDarklineColor {
    //e7e7e7
    return [UIColor colorWithHex:0xe9e9e9 alpha:1];
}


+ (UIColor *)BlueColor{
    return [UIColor colorWithHex:0x54c7e6 alpha:1];
}

+ (UIColor *)OrangeColor{
    return [UIColor colorWithHex:0xed6d00 alpha:1];
}

+ (UIColor *)MainColor{
    return [UIColor OrangeColor];
}

+ (UIColor *)lightMainColor{
    return [UIColor colorWithHex:0xfed2ad alpha:1];
}

+ (UIColor *)brightMainColor{
    return [UIColor colorWithHex:0x1CDDB1 alpha:1];
}
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hexValue & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

@end
