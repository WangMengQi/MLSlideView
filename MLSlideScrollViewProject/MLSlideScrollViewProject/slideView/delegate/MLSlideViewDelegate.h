//
//  MengQi_iPhone_SlideViewDelegate.h
//  Demo
//
//  Created by Wang Mengqi on 17/5/6.
//  Copyright © 2017年 WangMengQI. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MLSlideScrollView;

@protocol MLSlideViewDelegate <NSObject>

- (void)slideView:(MLSlideScrollView *)slideView didSwitchIndex:(NSInteger)index;
- (void)slideViewScrollView:(UIScrollView *)scollView;

@end
