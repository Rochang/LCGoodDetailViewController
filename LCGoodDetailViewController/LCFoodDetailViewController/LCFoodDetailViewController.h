//
//  LCFoodDetailViewController.h
//  LCProject
//
//  Created by liangrongchang on 2016/12/23.
//  Copyright © 2016年 Rochang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface LCFoodDetailViewController : UIViewController

/** 子类重写设置firstView下拉时文字 */
- (void)setupFirstVcFooterRefreshTextWithFooter:(MJRefreshBackStateFooter *)footer;

/** 子类重写设置secondView上拉时文字 */
- (void)setupSecondVcHeaderRefreshTextWithHeader:(MJRefreshStateHeader *)header;

/** 子类添加2个控制器 */
- (void)addTwoChildViewControllers;

/** 监听下拉刷新的回调 */
- (void)headDidRefresh:(UIScrollView *)scrollView;

@end
