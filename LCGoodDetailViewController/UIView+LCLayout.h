//
//  UIView+LCLayout.h
//  LCPlayer
//
//  Created by liangrongchang on 2017/3/8.
//  Copyright © 2017年 Rochang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LCLayout)

@property (nonatomic, assign) CGFloat LC_left;
@property (nonatomic, assign) CGFloat LC_top;
@property (nonatomic, assign) CGFloat LC_y;
@property (nonatomic, assign) CGFloat LC_x;
@property (nonatomic, assign) CGFloat LC_right;
@property (nonatomic, assign) CGFloat LC_bottom;
@property (nonatomic, assign) CGFloat LC_width;
@property (nonatomic, assign) CGFloat LC_height;
@property (nonatomic, assign) CGFloat LC_centerX;
@property (nonatomic, assign) CGFloat LC_centerY;
@property (nonatomic, assign) CGPoint LC_origin;
@property (nonatomic, assign) CGSize  LC_size;

@end
