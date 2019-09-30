//
//  ViewController.m
//  WNColorSet
//
//  Created by huweinan on 2019/9/29.
//  Copyright © 2019 jiyw. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+MoreColor.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *color = [UIColor colorWithHue:(21)/360.0 saturation:63/100.0 brightness:94/100.0 alpha:1];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2.0, self.view.frame.size.width, self.view.frame.size.height/2.0)];
    self.view.backgroundColor = color;
    [self.view addSubview:view];
//    UIColor *color2 = [UIColor colorWithHue:(360-2.5)/360.0 saturation:100.0/100 brightness:100.0/100 alpha:1];
    view.backgroundColor = [color shallowerColor];
//    view.backgroundColor = color2;
//    [color colorDeepthChangeWithHueChange:0 saturationChange:0 brightnessChange:0];
    // Do any additional setup after loading the view.
}


@end
