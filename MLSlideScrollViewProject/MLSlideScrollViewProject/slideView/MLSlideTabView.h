//
//  MengQi_iPhone_TabView.h
//  Demo
//
//  Created by WangMengQI on 2017/5/4.
//  Copyright © 2017年 WangMengQI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLSLideTabViewDataSource.h"
#import "MLSlideTabViewClickDelegte.h"
#import "MLSlideViewDelegate.h"

@class MLSlideScrollView;
extern CGFloat const defaultTimeInterval;

@interface MLSlideTabView : UIView

@property (nonatomic, weak) id<MLSlideTabViewClickDelegte> delegate;
@property (nonatomic, weak) id<MLSLideTabViewDataSource> dataSource;
@property (nonatomic, assign) CGFloat space;                      //每个文字之间的间隔
@property (nonatomic, strong) UIColor *normalTextColor;           //未选中的文字颜色
@property (nonatomic, strong) UIColor *selectedTextColor;         //选中之后的文字颜色
@property (nonatomic, assign) CGFloat normalTextFontSize;         //未选中的文字字体大小

@property (nonatomic, strong) UIColor *backGroundColor;           //整个tab条的背景颜色

@property (nonatomic, strong) UIColor *bottomLineColor;           //下方指示条颜色
@property (nonatomic, assign) CGFloat bottomLineHeight;           //下方指示条高度

@property (nonatomic, copy) NSArray<NSString *> *arrTabTitles;                //tab数据源数据

@property (nonatomic, assign) NSInteger selectedIndex;            //选中的第几个
@property (nonatomic, assign) NSInteger initalIndex;              //初始值选中的是第几个，为了处理指示条动画反弹的问题

@property (nonatomic, weak) MLSlideScrollView *slideView;


/**
 将指示条的偏移到哪个位置

 @param positionX 偏移多少
 */
- (void)scrollViewBottomLinePositionX:(CGFloat)positionX;

@end
