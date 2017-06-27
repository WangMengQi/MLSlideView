//
//  MLSlideScrollView1.m
//  ShowLive
//
//  Created by WangMengQI on 2017/5/18.
//  Copyright © 2017年 WangMengQI. All rights reserved.
//

#import "MLSlideScrollView.h"

@interface MLSlideScrollView()<MLSLideTabViewDataSource, UIScrollViewDelegate>
{
    //CGPoint panStartPoint;
    NSInteger _panToIndex;
    
    CGFloat bottomLineStartX;
}

@property (nonatomic, assign) NSInteger oldIndex;
@property (nonatomic, weak) UIViewController *oldViewController;

@property (nonatomic, weak) UIViewController *willViewController;
@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation MLSlideScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollView];
        _oldIndex = -1;
    }
    return self;
}

- (void)switchTo:(NSInteger)index
{
    if (index < 0 || index > [self.dataSource numberControllerInSlideView:nil] - 1) {
        return;
    }
    if (index == _oldIndex) {
        return;
    }
    [self showControllerAtIndex:index];
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width * index, 0) animated:YES];
}

- (void)showControllerAtIndex:(NSInteger)index
{
    if (_oldIndex == index) {
        return;
    }
    [self addWillViewControllerAtIndex:index];
    _oldIndex = index;
}

- (void)addWillViewControllerAtIndex:(NSInteger)index
{
    UIViewController *willViewController = [self controllerAtIndex:index];
    
    if (willViewController.parentViewController != self.baseViewController) {
        [willViewController willMoveToParentViewController:self.baseViewController];
        [self.baseViewController addChildViewController:willViewController];
        CGRect willRect = _scrollView.bounds;
        willRect.origin.x = _scrollView.bounds.size.width * index;
        willViewController.view.frame = willRect;
        [willViewController beginAppearanceTransition:YES animated:YES];
        [self.scrollView addSubview:willViewController.view];
        [willViewController endAppearanceTransition];
        [willViewController didMoveToParentViewController:self.baseViewController];
    }
    else {
        [willViewController beginAppearanceTransition:YES animated:YES];
        [willViewController endAppearanceTransition];
    }
    [_oldViewController beginAppearanceTransition:NO animated:YES];
    [_oldViewController endAppearanceTransition];
    _oldViewController = willViewController;
    _oldIndex = index;
}

- (UIViewController *)controllerAtIndex:(NSInteger)index
{
    if (index < 0 || index > [self.dataSource numberControllerInSlideView:self] - 1) {
        return nil;
    }
    UIViewController *controller = [self.cache controllerForKey:@(index)];
    if (controller == nil) {
        controller = [_dataSource tabControllerAtIndex:index];
        [self.cache setController:controller forKey:@(index)];
    }
    return controller;
}

#pragma mark - MengQi_iPhone_TabViewClickDelegte
- (void)tabViewClick:(UIButton *)button index:(NSInteger)index
{
    if (index < 0 || index > [self.dataSource numberControllerInSlideView:nil] - 1) {
        return;
    }
    [self showControllerAtIndex:index];
}

#pragma mark - MengQi_iPhone_TabViewDataSource
- (UIViewController *)tabControllerAtIndex:(NSInteger)index
{
    return [self controllerAtIndex:index];
}

- (NSInteger)numberControllerInSlideView:(MLSlideScrollView *)slideView
{
    return [self.dataSource numberControllerInSlideView:self];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger floorIndex = floor(scrollView.contentOffset.x / scrollView.bounds.size.width);
    CGFloat offsetX = scrollView.contentOffset.x - floorIndex * scrollView.bounds.size.width;
    
    NSInteger panToIndex = -1;
    if (offsetX > 0) {
        panToIndex = floorIndex + 1;
    } else {
        panToIndex = floorIndex - 1;
    }
    if (panToIndex <= -1 || panToIndex >= [_dataSource numberControllerInSlideView:self]) {
        return;
    }

    if ([_slideDelegate respondsToSelector:@selector(slideViewScrollView:)]) {
        [_slideDelegate slideViewScrollView:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger floorIndex = floor(scrollView.contentOffset.x / scrollView.bounds.size.width);
    CGFloat offsetX = scrollView.contentOffset.x - floorIndex * scrollView.bounds.size.width;
    NSInteger panToIndex = -1;
    if (offsetX > 0) {
        panToIndex = floorIndex + 1;
    } else if(offsetX < 0){
        panToIndex = floorIndex - 1;
    } else {
        panToIndex = floorIndex;
    }
    if (panToIndex <= -1 || panToIndex >= [_dataSource numberControllerInSlideView:self]) {
        return;
    }
    [self addWillViewControllerAtIndex:panToIndex];
    if ([_slideDelegate respondsToSelector:@selector(slideView:didSwitchIndex:)]) {
        [_slideDelegate slideView:self didSwitchIndex:panToIndex];
    }
}

- (void)setDataSource:(id<MLSLideTabViewDataSource>)dataSource
{
    _dataSource = dataSource;
    NSInteger numberOfControllers = [dataSource numberControllerInSlideView:self];
    [_scrollView setContentSize:CGSizeMake(numberOfControllers * _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollsToTop = NO;
        _scrollView.delegate = self;
        _scrollView.decelerationRate = 0.1;
        _scrollView.directionalLockEnabled = YES;
    }
    return _scrollView;
}

- (void)setSpace:(CGFloat)space
{
    _space = space;
    CGRect frame = _scrollView.frame;
    frame.size.width += _space;
    _scrollView.frame = frame;
    NSInteger numberOfControllers = [_dataSource numberControllerInSlideView:self];
    [_scrollView setContentSize:CGSizeMake(numberOfControllers * _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
}

@end
