//
//  UIColor+MoreColor.h
//  WNColorSet
//
//  Created by huweinan on 2019/9/29.
//  Copyright © 2019 jiyw. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (MoreColor)
#pragma mark - str to color
//例如0x000000
+ (UIColor *)colorWithHex:(long)hexColor;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;
//支持argb、rgb 例如 #12345678、#123456
+ (instancetype)colorWithHexStr:(NSString *)argb;

#pragma mark - 颜色深浅相关
-(instancetype)colorDeepthChangeWithHueChange:(CGFloat)hueChange saturationChange:(CGFloat)saturationChange brightnessChange:(CGFloat)brightnessChange;

-(instancetype)deepthColorWithPercent:(CGFloat)percent;

-(instancetype)deeperColor;

-(instancetype)shallowerColor;
@end

NS_ASSUME_NONNULL_END
