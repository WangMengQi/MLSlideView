//
//  MengQi_iPhone_TabView.m
//  Demo
//
//  Created by WangMengQI on 2017/5/4.
//  Copyright © 2017年 WangMengQI. All rights reserved.
//

#import "MLSlideTabView.h"
#import "MLSlideScrollView.h"
#import "MLSlideTabItemCollectionViewCell.h"

CGFloat const defaultSpace = 30.0;
CGFloat const defaulNormalTextFontSize = 15.0;
CGFloat const defaultSelectedTextFontSize = 15.0;
CGFloat const defaultTimeInterval = 0.5;
NSInteger const defaultButtonIndex = 0;


@interface MLSlideTabView()<MLSlideViewDelegate, MLSLideTabViewDataSource, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation MLSlideTabView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _selectedIndex = -1;
        _space = defaultSpace;
        _normalTextColor = [UIColor grayColor];
        _selectedTextColor = [UIColor whiteColor];
        _normalTextFontSize = defaulNormalTextFontSize;
        _bottomLineColor = _selectedTextColor;
        _bottomLineHeight = 2.0;
        _backGroundColor = [UIColor clearColor];
        [self afterViews];
    }
    return self;
}

#pragma mark - response
- (void)tabButtonClick:(UIButton *)tabButton
{
    NSInteger index = tabButton.tag - defaultButtonIndex;
    if (_selectedIndex == index) {
        return;
    }
    self.selectedIndex = index;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    [_slideView switchTo:selectedIndex];
    if ([_delegate respondsToSelector:@selector(tabViewClickIndex:)]) {// && selectedIndex != _selectedIndex
        [_delegate tabViewClickIndex:selectedIndex];
    }
    if (_selectedIndex == selectedIndex) {
        return;
    }
    if (selectedIndex < 0 || selectedIndex > [self.dataSource numberControllerInSlideView:nil] - 1) {
        return;
    }
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:selectedIndex inSection:0];
//    UICollectionViewLayoutAttributes *newAttributes = [_collectionView layoutAttributesForItemAtIndexPath:newIndexPath];
//    CGFloat width = newAttributes.frame.size.width - _space;
//    CGFloat positionX = newAttributes.frame.origin.x + _space/2;
    [_collectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    _selectedIndex = selectedIndex;
    [UIView animateWithDuration:defaultTimeInterval animations:^{
        [_collectionView reloadData];
        
        //[self scrollViewBottomLinePositionX:positionX bottomLineWidth:width];
    }];
}

- (void)setInitalIndex:(NSInteger)initalIndex
{
    self.selectedIndex = initalIndex;
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:initalIndex inSection:0];
    UICollectionViewLayoutAttributes *newAttributes = [_collectionView layoutAttributesForItemAtIndexPath:newIndexPath];
    [self scrollViewBottomLinePositionX:newAttributes.frame.origin.x + _space/2 bottomLineWidth:newAttributes.frame.size.width - _space];
}

/**
 滚动的过程设置指示条的位置和宽度

 @param positionX 指示条的X位置
 @param width 指示条的宽度
 */
- (void)scrollViewBottomLinePositionX:(CGFloat)positionX bottomLineWidth:(CGFloat)width
{
    CGRect bottomLineFrame = _bottomLineView.frame;
    bottomLineFrame.origin.x = positionX;
    bottomLineFrame.size.width = width;
    [_bottomLineView setFrame:bottomLineFrame];
}

- (void)scrollViewBottomLinePositionX:(CGFloat)positionX //original:
{
    CGRect bottomLineFrame = _bottomLineView.frame;
    bottomLineFrame.origin.x = positionX;
    [_bottomLineView setFrame:bottomLineFrame];
}

#pragma mark - MengQi_iPhone_TabViewDataSource
- (UIViewController *)tabControllerAtIndex:(NSInteger)index
{
    return [self.dataSource tabControllerAtIndex:index];
}
- (NSInteger)numberControllerInSlideView:(MLSlideScrollView *)slideView
{
    return [self.dataSource numberControllerInSlideView:_slideView];
}

#pragma mark - MengQi_iPhone_SlideViewDelegate
- (void)slideView:(MLSlideScrollView *)slideView didSwitchIndex:(NSInteger)index
{
    self.selectedIndex = index - defaultButtonIndex;
}

- (void)slideViewScrollView:(UIScrollView *)scrollView
{
    NSInteger floorIndex = floor(scrollView.contentOffset.x / scrollView.bounds.size.width);
    CGFloat offsetX = scrollView.contentOffset.x - floorIndex * scrollView.bounds.size.width;
    
    NSInteger panToIndex = -1;
    if (offsetX > 0) {
        panToIndex = floorIndex + 1;
    } else {
        panToIndex = floorIndex - 1;
    }
    if (panToIndex <= -1 || panToIndex >= [_dataSource numberControllerInSlideView:_slideView]) {
        return;
    }
    if (floorIndex <= -1 || panToIndex >= [_dataSource numberControllerInSlideView:_slideView]) {
        return;
    }
    
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForItem:floorIndex inSection:0];
    UICollectionViewLayoutAttributes *oldAttributes = [_collectionView layoutAttributesForItemAtIndexPath:oldIndexPath];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:panToIndex inSection:0];
    UICollectionViewLayoutAttributes *newAttributes = [_collectionView layoutAttributesForItemAtIndexPath:newIndexPath];
    
    CGFloat factor = offsetX / CGRectGetWidth(_slideView.frame);
    CGFloat positionX = 0.0;
    if (factor > 0) {//右移
        positionX = oldAttributes.frame.origin.x + _space/2 + (oldAttributes.frame.size.width) * factor;
    } else {
        positionX = oldAttributes.frame.origin.x + _space/2 + newAttributes.frame.size.width * factor;
    }
    
    CGFloat willWidth = oldAttributes.frame.size.width - _space + (newAttributes.frame.size.width - _space - (oldAttributes.frame.size.width - _space)) * fabs(factor);
    [self scrollViewBottomLinePositionX:positionX bottomLineWidth:willWidth];
}

#pragma mark - UI
- (void)afterViews
{
    [self addSubview:self.collectionView];
    [self.collectionView addSubview:self.bottomLineView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arrTabTitles.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MLSlideTabItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MLSlideTabItemCollectionViewCell class]) forIndexPath:indexPath];
    cell.normalTextFontSize = _normalTextFontSize;
    cell.normalTextColor = _normalTextColor;
    cell.selectedTextColor = _selectedTextColor;
    [cell setText:_arrTabTitles[indexPath.item]];
    if (_selectedIndex == indexPath.item) {
        cell.didSelected = YES;
    } else {
        cell.didSelected = NO;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([MLSlideTabItemCollectionViewCell widthForText:_arrTabTitles[indexPath.item] font:_normalTextFontSize space:_space], self.frame.size.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self setSelectedIndex:indexPath.item];
}

#pragma mark - getter  setter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[MLSlideTabItemCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MLSlideTabItemCollectionViewCell class])];
    }
    return _collectionView;
}

- (UIView *)bottomLineView
{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 5.0, 0, _bottomLineHeight)];
        [_bottomLineView setBackgroundColor:_bottomLineColor];
    }
    return _bottomLineView;
}

- (void)setArrTabTitles:(NSArray *)arrTabTitles
{
    _arrTabTitles = [arrTabTitles copy];
    [self.collectionView reloadData];
    self.selectedIndex = 0;
}

- (void)setBackGroundColor:(UIColor *)backGroundColor
{
    _backGroundColor = backGroundColor;
    self.backgroundColor = backGroundColor;
}

- (void)setSlideView:(MLSlideScrollView *)slideView
{
    _slideView = slideView;
    _slideView.dataSource = self;
    _slideView.slideDelegate = self;
}

@end
