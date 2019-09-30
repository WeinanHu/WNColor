//
//  UIColor+MoreColor.m
//  WNColorSet
//
//  Created by huweinan on 2019/9/29.
//  Copyright © 2019 jiyw. All rights reserved.
//

#import "UIColor+MoreColor.h"


@implementation UIColor (MoreColor)
#pragma mark - str to color

+ (UIColor*) colorWithHex:(long)hexColor;
{
    return [UIColor colorWithHex:hexColor alpha:1.];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity
{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

+ (instancetype)colorWithHexStr:(NSString *)argb {
    NSAssert([argb hasPrefix:@"#"], @"颜色字符串要以#开头");
    
    NSString *hexString = [argb substringFromIndex:1];
    unsigned int hexInt;
    BOOL result = [[NSScanner scannerWithString:hexString] scanHexInt:&hexInt];
    if (!result) {
        return nil;
    }
    
    CGFloat divisor = 255.0;
    CGFloat alpha = ((hexInt & 0xFF000000) >> 24) / divisor;
    CGFloat red   = ((hexInt & 0x00FF0000) >> 16) / divisor;
    CGFloat green    = ((hexInt & 0x0000FF00) >>  8) / divisor;
    CGFloat blue   = ( hexInt & 0x000000FF       ) / divisor;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
}
#pragma mark - 颜色深浅相关
-(instancetype)colorDeepthChangeWithHueDegreeChange:(CGFloat)hueDegreeChange saturationChange:(CGFloat)saturationChange brightnessChange:(CGFloat)brightnessChange{
    CGFloat h=0,s=0,b=0,a=0;
    
    if ([self respondsToSelector:@selector(getHue:saturation:brightness:alpha:)]) {
        
        [self getHue:&h saturation:&s brightness:&b alpha:&a];
        
    }
    CGFloat hNew = h+hueDegreeChange/360;
    hNew = hNew>1?1:(hNew<0?0:hNew);
    CGFloat sNew = s+saturationChange/100;
    sNew = sNew>1?1:(sNew<0?0:sNew);
    CGFloat bNew = b+brightnessChange/100;
    bNew = bNew>1?1:(bNew<0?0:bNew);
    
    UIColor *color = [UIColor colorWithHue:hNew saturation:sNew brightness:bNew alpha:a];
    return color;
}

-(instancetype)deepthColorWithPercent:(CGFloat)percent{
    CGFloat h=0,s=0,b=0,a=0;
    if ([self respondsToSelector:@selector(getHue:saturation:brightness:alpha:)]) {
        [self getHue:&h saturation:&s brightness:&b alpha:&a];
    }
    /*
     h范围：0-360；
        在0-60度      光度变化 30-89
        在60-120度    光度变化 89-58
        在120-180度   光度变化 58-69
        在180-240度   光度变化 69-10
        在240-300度   光度变化 10-41
        在300-360读   光度变化 41-30
     s范围：0-100；
     b范围：0-100；
     但是在代码中hsb范围都是0-1
     */
    CGFloat lul[] = {30,89,58,69,10,41};
    CGFloat lur[] = {89,58,69,10,41,30};
    CGFloat hD = h*360;
    CGFloat sD = s*100;
    CGFloat bD = b*100;
    int p = ((int)hD)/60;
    CGFloat hDes = hD;
    CGFloat sPercent = percent*100/360;
    if (((int)hD)%120>60) {
        //降
        CGFloat length;
        if (percent>0) {
            length = hD-lur[p];
        }else{
            length = hD-lul[p];
        }
        hDes = hDes + sPercent*length;
        
    }else{
        //升
        CGFloat length;
        if (percent>0) {
            length = hD-lul[p];
        }else{
            length = hD-lur[p];
        }
        hDes = hDes + sPercent*length;
    }
    CGFloat sDes = sD;
    CGFloat bDes = bD;
    if (percent>0) {
        sDes = sDes + (100-sDes)*percent;
        bDes = bDes - (bDes)*percent;
    }else{
        sDes = sDes + (sDes)*percent;
        bDes = bDes - (100-bDes)*percent;
    }
    CGFloat hNew = hDes/360;
    hNew = hNew>1?1:(hNew<0?0:hNew);
    CGFloat sNew = sDes/100;
    sNew = sNew>1?1:(sNew<0?0:sNew);
    CGFloat bNew = bDes/100;
    bNew = bNew>1?1:(bNew<0?0:bNew);
    NSLog(@"hsb:%@  %@  %@\nhsb new:%@  %@  %@",@(hD),@(sD),@(bD),@(hDes),@(sDes),@(bDes));
    UIColor *color = [UIColor colorWithHue:hNew saturation:sNew brightness:bNew alpha:a];
    return color;
}

-(instancetype)deeperColor{
    return [self deepthColorWithPercent:0.1];
}
-(instancetype)shallowerColor{
    return [self deepthColorWithPercent:-0.1];
}

@end
