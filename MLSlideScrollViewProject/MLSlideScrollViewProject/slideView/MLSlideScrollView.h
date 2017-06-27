//
//  MLSlideScrollView1.h
//  ShowLive
//
//  Created by WangMengQI on 2017/5/18.
//  Copyright © 2017年 WangMengQI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLSlideTabView.h"
#import "MLSLideTabViewDataSource.h"
#import "MLSlideViewDelegate.h"
#import "MLControllerCache.h"

@interface MLSlideScrollView : UIView

@property (nonatomic, weak) UIViewController *baseViewController;//需要添加到的controller
@property (nonatomic, weak) id<MLSLideTabViewDataSource> dataSource;
@property (nonatomic, weak) id<MLSlideViewDelegate> slideDelegate;
@property (nonatomic, strong) MLControllerCache *cache;          //缓存controller

@property (nonatomic, assign) CGFloat space;     //每个页面之间的间隔


/**
 tab切换哪个index
 
 @param index 是切换到第几个
 */
- (void)switchTo:(NSInteger)index;

@end
