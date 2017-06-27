//
//  MLSlideTabItemCollectionViewCell.h
//  ShowLive
//
//  Created by WangMengQI on 2017/5/12.
//  Copyright © 2017年 WangMengQI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLSlideTabItemCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIColor *normalTextColor;
@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic, assign) CGFloat normalTextFontSize;

@property (nonatomic, assign) BOOL didSelected;

- (void)setText:(NSString *)text;

+ (CGFloat)widthForText:(NSString *)text font:(CGFloat)font space:(CGFloat)space;

@end
