//
//  ViewController.m
//  LCGoodDetailViewController
//
//  Created by liangrongchang on 2017/8/9.
//  Copyright © 2017年 Rochang. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "CustomTitleScrollViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)addTwoChildViewControllers {
    FirstViewController *firstVc = [[FirstViewController alloc] init];
    [self addChildViewController:firstVc];
    
    CustomTitleScrollViewController *secondVc = [[CustomTitleScrollViewController alloc] init];
    [self addChildViewController:secondVc];
}


@end
