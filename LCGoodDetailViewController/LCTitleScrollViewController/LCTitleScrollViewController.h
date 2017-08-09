//
//  LCTitleScrollViewController.h
//  UITitleScrollView
//
//  Created by liangrongchang on 16/8/18.
//  Copyright © 2016年 LC. All rights reserved.

#import <UIKit/UIKit.h>

@interface LCTitleScrollViewController : UIViewController

/** 重写添加子控制器 */
- (void)setupChildViewControllers;

/** 重写设置titleButon属性返回titleButton的宽度 */
- (CGFloat)comfiguretitleView:(UIButton *)button buttonCounts:(NSUInteger)count superViewWidth:(CGFloat)width;

/** 重写设置underLine属性的,返回underLine的宽度 */
- (CGFloat)comfigureUnderLine:(UIView *)underLine titltButton:(UIButton *)button;

/** 重写监听titleButton点击 */
- (void)titleButtonDidClick:(UIButton *)button index:(NSUInteger)index;

/** 代码设置选择button的index */
- (void)setIndexForTitleScrollViewController:(NSInteger)index animate:(BOOL)animate;

/** 获取当前显示Vc的index*/
- (NSInteger)indexforTitleScrollViewController;



@end
