//
//  MengQi_iPhone_TabViewDataSource.h
//  Demo
//
//  Created by WangMengQI on 2017/5/5.
//  Copyright © 2017年 WangMengQI. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MLSlideScrollView;

@protocol MLSLideTabViewDataSource <NSObject>

- (UIViewController *)tabControllerAtIndex:(NSInteger)index;
- (NSInteger)numberControllerInSlideView:(MLSlideScrollView *)slideView;

@end
