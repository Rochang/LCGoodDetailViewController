//
//  LCFoodDetailViewController.m
//  LCProject
//
//  Created by liangrongchang on 2016/12/23.
//  Copyright © 2016年 Rochang. All rights reserved.
//

#import "LCFoodDetailViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "UIView+LCLayout.h"

static NSTimeInterval duration = 0.5;
static UIScrollView *fisrtscrollView;
static UIScrollView *secondScrollView;

@interface LCFoodDetailViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *bgScrollView;
@property (strong, nonatomic) UIScrollView *topScrollView;
@property (strong, nonatomic) UIScrollView *bottomScrollView;

@end

@implementation LCFoodDetailViewController
#pragma mark - API
- (void)addTwoChildViewControllers {
    NSLog(@"重写方法addTwoChildViewControllers\n\n");
    FirstViewController *firstVc = [[FirstViewController alloc] init];
    [self addChildViewController:firstVc];
    
    SecondViewController *secondVc = [[SecondViewController alloc] init];
    [self addChildViewController:secondVc];
    
}

- (void)headDidRefresh:(UIScrollView *)scrollView {
    NSLog(@"重写该方法实现监听下拉刷新的回调\n\n");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [scrollView.mj_header endRefreshing];
    });
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"商品详情";
    [self addTwoChildViewControllers];
    if (self.childViewControllers.count != 2) {
        NSLog(@"请参考父类,添加2个控制器");
        return;
    }
    
    // 添加2个veiw
    [self.view addSubview:self.bgScrollView];
    UIView *childFirstView = self.childViewControllers[0].view;
    UIView *childSecondView = self.childViewControllers[1].view;
    
    if ([childFirstView isKindOfClass:[UIScrollView class]]) {
        [self addMJRefreshForFirstView:(UIScrollView *)childFirstView];
        [self.bgScrollView addSubview:childFirstView];
    } else {
        [self.bgScrollView addSubview:self.topScrollView];
        [self.topScrollView addSubview:childFirstView];
        [self addMJRefreshForFirstView:self.topScrollView];
    }
    
    if ([childSecondView isKindOfClass:[UIScrollView class]]) {
        [self addMJRefreshForsecondView:(UIScrollView *)childSecondView];
        [self.bgScrollView addSubview:childSecondView];
    } else {
        [self.bgScrollView addSubview:self.bottomScrollView];
        [self.bottomScrollView addSubview:childSecondView];
        [self addMJRefreshForsecondView:self.bottomScrollView];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat y = self.navigationController ? 64 : 0;
    self.bgScrollView.frame = CGRectMake(0, y, self.view.LC_width, self.view.LC_height - y);
    self.topScrollView.frame = CGRectMake(0, 0, self.bgScrollView.LC_width, self.bgScrollView.LC_height);
    self.bottomScrollView.frame = CGRectMake(0, self.topScrollView.LC_height, self.bgScrollView.LC_width, self.bgScrollView.LC_height);
    
    self.childViewControllers[0].view.frame = self.bgScrollView.bounds;
    
    if ([self.childViewControllers[1].view isKindOfClass:[UIScrollView class]]) {
        self.childViewControllers[1].view.frame = CGRectMake(0, self.bgScrollView.LC_height, self.bgScrollView.LC_width, self.bgScrollView.LC_height);
    } else{
        self.childViewControllers[1].view.frame = self.bgScrollView.bounds;
    }
    
    self.topScrollView.contentSize = CGSizeMake(0, self.childViewControllers[0].view.LC_height);
    self.bottomScrollView.contentSize = CGSizeMake(0, self.childViewControllers[1].view.LC_height);
}

#pragma mark - private method

- (void)setupFirstVcFooterRefreshTextWithFooter:(MJRefreshBackStateFooter *)footer{
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"" forState:MJRefreshStatePulling];
    [footer setTitle:@"" forState:MJRefreshStateRefreshing];}

- (void)setupSecondVcHeaderRefreshTextWithHeader:(MJRefreshStateHeader *)header {
    [header setTitle:@"下拉回到商品详情" forState:MJRefreshStateIdle];
    [header setTitle:@"释放回到商品详情" forState:MJRefreshStatePulling];
    [header setTitle:@"正在切换商品详情" forState:MJRefreshStateRefreshing];
}

- (void)addMJRefreshForFirstView:(UIScrollView *)firstView {
    fisrtscrollView = firstView;
    MJRefreshNormalHeader *goodsheader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(goodsHeaderRefresh)];
    firstView.mj_header = goodsheader;
    
    MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    [self setupFirstVcFooterRefreshTextWithFooter:footer];
    firstView.mj_footer = footer;
}

- (void)addMJRefreshForsecondView:(UIScrollView *)secondView {
    secondScrollView = secondView;
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    header.lastUpdatedTimeLabel.hidden = YES;
    [self setupSecondVcHeaderRefreshTextWithHeader:header];
    secondView.mj_header = header;
}

#pragma mark - response method
- (void)goodsHeaderRefresh {
    [self headDidRefresh:fisrtscrollView];
}

- (void)footerRefresh {
    [fisrtscrollView.mj_footer endRefreshing];
//    [self.bgScrollView setContentOffset:CGPointMake(0, self.bgScrollView.LC_height) animated:YES];
    
    // 控制动画时间
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.bgScrollView.contentOffset = CGPointMake(0, self.bgScrollView.LC_height);
    } completion:^(BOOL finished) {
        self.navigationItem.title = @"图文详情";
    }];
}

- (void)headerRefresh {
    [secondScrollView.mj_header endRefreshing];
    
//    [self.bgScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.bgScrollView.contentOffset = CGPointMake(0, 0);
    } completion:^(BOOL finished) {
        self.navigationItem.title = @"商品详情";
    }];
}

#pragma mark - getter

- (UIScrollView *)bgScrollView {
    if (!_bgScrollView) {
        _bgScrollView = [self scrollViewWithFrame:CGRectZero delegate:self showsHorizontal:NO showVertical:NO pagingEnable:NO bounces:NO backColor:[UIColor clearColor]];
    }
    return _bgScrollView;
}

- (UIScrollView *)topScrollView {
    if (!_topScrollView) {
        _topScrollView = [self scrollViewWithFrame:CGRectZero delegate:self showsHorizontal:NO showVertical:NO pagingEnable:NO bounces:YES backColor:[UIColor clearColor]];
    }
    return _topScrollView;
}

- (UIScrollView *)bottomScrollView {
    if (!_bottomScrollView) {
        _bottomScrollView = [self scrollViewWithFrame:CGRectZero delegate:self showsHorizontal:NO showVertical:NO pagingEnable:NO bounces:YES backColor:[UIColor clearColor]];
    }
    return _bottomScrollView;
}

- (UIScrollView *)scrollViewWithFrame:(CGRect)frame delegate:(id<UIScrollViewDelegate>)delegete showsHorizontal:(BOOL)horizontal showVertical:(BOOL)vertical pagingEnable:(BOOL)page bounces:(BOOL)bounces backColor:(UIColor *)backColor {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.delegate = delegete;
    scrollView.showsHorizontalScrollIndicator = horizontal;
    scrollView.showsVerticalScrollIndicator = vertical;
    scrollView.pagingEnabled = page;
    scrollView.bounces = bounces;
    scrollView.backgroundColor = backColor;
    return scrollView;
}
@end
