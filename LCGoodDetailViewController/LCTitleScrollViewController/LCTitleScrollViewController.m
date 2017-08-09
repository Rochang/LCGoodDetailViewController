//
//  LCTitleScrollViewController.m
//  UITitleScrollView
//
//  Created by liangrongchang on 16/8/18.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCTitleScrollViewController.h"
#import "UIView+LCLayout.h"

static CGFloat titleUnderLine = 2;
static NSInteger titleCounts = 0;
static CGFloat titleWidth = 0;

#define TabBarHeight 49
#define NavHeight 64

@interface LCTitleScrollViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *titleScrollView;
@property (strong, nonatomic) UIScrollView *contentScrollView;
@property (strong, nonatomic) NSMutableArray <UIButton *>*titleButtons;
@property (strong, nonatomic) UIButton *selectButton;
@property (strong, nonatomic) UIView *underLine;
@property (nonatomic, assign) CGRect underLineFrame;

@end

@implementation LCTitleScrollViewController
#pragma mark - API
- (void)setIndexForTitleScrollViewController:(NSInteger)index animate:(BOOL)animate {
    if (index > self.childViewControllers.count - 1) {
        NSLog(@"index越界");
        return;
    }
    [self clickTitleButton:self.titleButtons[index] animation:animate];
}

- (NSInteger)indexforTitleScrollViewController {
    return self.selectButton.tag;
}

- (BOOL)contentViewCanScroll {
    return YES;
}

- (BOOL)titleButtonTopBottom {
    return NO;
}

- (void)setupChildViewControllers {
    UIViewController *firstVc = [[UIViewController alloc] init];
    firstVc.title = @"first";
    firstVc.view.backgroundColor = [UIColor grayColor];
    [self addChildViewController:firstVc];
    
    UIViewController *secondVc = [[UIViewController alloc] init];
    secondVc.title = @"second";
    secondVc.view.backgroundColor = [UIColor darkGrayColor];
    [self addChildViewController:secondVc];
    
    UIViewController *thirdVc = [[UIViewController alloc] init];
    thirdVc.title = @"third";
    thirdVc.view.backgroundColor = [UIColor lightGrayColor];
    [self addChildViewController:thirdVc];
    
    UIViewController *forthVc = [[UIViewController alloc] init];
    forthVc.title = @"fourth";
    forthVc.view.backgroundColor = [UIColor orangeColor];
    [self addChildViewController:forthVc];
}

- (void)titleButtonDidClick:(UIButton *)butotn index:(NSUInteger)index {

}

- (CGFloat)comfiguretitleView:(UIButton *)button buttonCounts:(NSUInteger)count superViewWidth:(CGFloat)width {
    return width / count;
}

- (CGFloat)comfigureUnderLine:(UIView *)underLine titltButton:(UIButton *)button {
    return 0;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.navigationController) {
        self.navigationItem.title = @"LCTitleScrollViewController";
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self setupChildViewControllers];
    [self.view addSubview:self.titleScrollView];
    [self setupTitlesScorllView];
    [self.view addSubview:self.contentScrollView];
    [self setupContentScrollView];
    self.titleScrollView.contentSize = CGSizeMake(titleWidth * titleCounts, 0);
}

#pragma mark - system delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / self.contentScrollView.LC_width;
    UIButton *button = self.titleButtons[index];
    [self titleButtonDidClick:button];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scale = scrollView.contentOffset.x / self.view.LC_width;
    self.underLine.frame = CGRectOffset(self.underLineFrame, self.titleButtons.firstObject.LC_width * scale, 0);
}

#pragma mark - event response
/** 选中标题的处理 */
- (void)titleButtonDidClick:(UIButton *)button {
    [self clickTitleButton:button animation:YES];
}

- (void)clickTitleButton:(UIButton *)button animation:(BOOL)animation {
    
    [self setupSelectButton:button];
    [self setupTitleCenter:button animation:animation];
    [self setupUnderLine:button animation:animation];
    [self titleButtonDidClick:button index:button.tag];
    [self.contentScrollView setContentOffset:CGPointMake(button.tag * self.contentScrollView.LC_width, 0) animated:NO];
}

#pragma mark - private methods
/** 创建titleScrollView的按钮 */
- (void)setupTitlesScorllView {
    // 清空
    for (UIView *view in self.titleScrollView.subviews) {
        [view removeFromSuperview];
    }
    [self.titleButtons removeAllObjects];
    
    titleCounts = self.childViewControllers.count;
    NSArray *titles = [self.childViewControllers valueForKeyPath:@"title"];
   
    // 添加所有标题
    for (int i = 0; i < titleCounts; i++) {
        // 创建按钮
        UIButton *button = [[UIButton alloc] init];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        titleWidth = [self comfiguretitleView:button buttonCounts:titleCounts superViewWidth:self.titleScrollView.LC_width];
        button.frame = CGRectMake(titleWidth * i, 0, titleWidth, 44);
        [button addTarget:self action:@selector(titleButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [self.titleScrollView addSubview:button];
        [self.titleButtons addObject:button];
        if (i == 0) [self titleButtonDidClick:button];
    }
    CGFloat underLineW = [self comfigureUnderLine:self.underLine titltButton:self.titleButtons.firstObject];
    if (underLineW > titleWidth) {
        NSLog(@"下划线宽度 > titleButton宽度");
    }
    if (underLineW == 0) {
        return;
    }
    CGFloat underLineX = (titleWidth - underLineW) / 2;
    CGFloat underLineH = self.underLine.LC_height ? self.underLine.LC_height : titleUnderLine;
    self.underLineFrame = self.underLine.frame = CGRectMake(underLineX, self.titleScrollView.LC_height - underLineH, underLineW, underLineH);
    [self.titleScrollView insertSubview:self.underLine atIndex:0];
}

#pragma mark - 创建contentScrollView中的view
- (void)setupContentScrollView {
    for(int i = 0; i < self.childViewControllers.count; i++){
        UIViewController *childVc = self.childViewControllers[i];
        if ([childVc isKindOfClass:[self class]]) {
            NSLog(@"控制器不能即为子控制器又为父控制器,请检查setupChildViewControllers方法");
            return;
        }
        childVc.view.frame = CGRectMake(self.contentScrollView.LC_width * i, 0, self.contentScrollView.LC_width, self.contentScrollView.LC_height);
        [self.contentScrollView addSubview:childVc.view];
    }
    self.contentScrollView.contentSize = CGSizeMake(self.view.LC_width * titleCounts, 0);
}

#pragma mark - 选中标题居中
- (void)setupTitleCenter:(UIButton *)button animation:(BOOL)animation {
    CGFloat offsetX = button.center.x - self.view.LC_width * 0.5;
    if (offsetX < 0) offsetX = 0;
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - self.view.LC_width;
    
    if (maxOffsetX <= 0) return;
    
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    
    [_titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:animation];
}

/** 标题选中效果 */
- (void)setupSelectButton:(UIButton *)button {
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
}

/** 设置underLine的位置 */
- (void)setupUnderLine:(UIButton *)button animation:(BOOL)animation {
    if (!animation) {
        self.underLine.LC_centerX = button.LC_centerX;
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.underLine.LC_centerX = button.LC_centerX;
    }];
}

#pragma mark - getter
- (UIScrollView *)titleScrollView {
    if (!_titleScrollView) {
        CGRect frame = CGRectMake(0, 0, self.view.LC_width, 44);
        _titleScrollView = [self scrollViewWithFrame:frame delegate:nil showsHorizontal:NO showVertical:NO pagingEnable:NO bounces:NO backColor:[UIColor whiteColor]];
    }
    return _titleScrollView;
}

- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        CGFloat contentH = self.hidesBottomBarWhenPushed ? self.view.LC_height - self.titleScrollView.LC_bottom: self.view.LC_height - self.titleScrollView.LC_bottom - TabBarHeight;
        CGRect frame = CGRectMake(0, self.titleScrollView.LC_bottom, self.view.LC_width, contentH);
        _contentScrollView = [self scrollViewWithFrame:frame delegate:self showsHorizontal:NO showVertical:NO pagingEnable:YES bounces:NO backColor:[UIColor whiteColor]];
    }
    return _contentScrollView;
}

- (NSMutableArray<UIButton *> *)titleButtons {
    if (!_titleButtons) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}

- (UIView *)underLine {
    if (!_underLine) {
        _underLine = [[UIView alloc] init];
        _underLine.backgroundColor = [UIColor redColor];
    }
    return _underLine;
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
