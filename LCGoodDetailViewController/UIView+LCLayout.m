//
//  UIView+LCLayout.m
//  LCPlayer
//
//  Created by liangrongchang on 2017/3/8.
//  Copyright © 2017年 Rochang. All rights reserved.
//

#import "UIView+LCLayout.h"

@implementation UIView (LCLayout)

- (CGFloat)LC_left {
    return self.frame.origin.x;
}

- (void)setLC_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)LC_top {
    return self.frame.origin.y;
}

- (void)setLC_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)LC_x {
    return self.frame.origin.x;
}

- (void)setLC_x:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)LC_y {
    return self.frame.origin.y;
}

- (void)setLC_y:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)LC_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setLC_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)LC_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLC_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)LC_width {
    return self.frame.size.width;
}

- (void)setLC_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)LC_height {
    return self.frame.size.height;
}

- (void)setLC_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)LC_centerX {
    return self.center.x;
}

- (void)setLC_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)LC_centerY {
    return self.center.y;
}

- (void)setLC_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)LC_origin {
    return self.frame.origin;
}

- (void)setLC_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)LC_size {
    return self.frame.size;
}

- (void)setLC_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
