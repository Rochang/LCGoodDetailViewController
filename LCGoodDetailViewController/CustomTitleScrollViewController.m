//
//  CustomTitleScrollViewController.m
//  LCGoodDetailViewController
//
//  Created by liangrongchang on 2017/8/9.
//  Copyright © 2017年 Rochang. All rights reserved.
//

#import "CustomTitleScrollViewController.h"

@interface CustomTitleScrollViewController ()

@end

@implementation CustomTitleScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (CGFloat)comfigureUnderLine:(UIView *)underLine titltButton:(UIButton *)button {
    return button.frame.size.width;
}

@end
