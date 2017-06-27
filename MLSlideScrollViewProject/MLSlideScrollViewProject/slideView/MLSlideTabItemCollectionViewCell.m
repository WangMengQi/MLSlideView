//
//  MLSlideTabItemCollectionViewCell.m
//  ShowLive
//
//  Created by WangMengQI on 2017/5/12.
//  Copyright © 2017年 WangMengQI. All rights reserved.
//

#import "MLSlideTabItemCollectionViewCell.h"

CGFloat const defaultButtonScale = 1.1;

@interface MLSlideTabItemCollectionViewCell()

@property (nonatomic, strong) UILabel *lblTitle;

@end

@implementation MLSlideTabItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self afterViews];
        [self resize];
    }
    return self;
}

- (void)afterViews
{
    [self.contentView addSubview:self.lblTitle];
}

- (void)resize
{
    [_lblTitle setCenter:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2)];
}

#pragma mark - getter setter
- (UILabel *)lblTitle
{
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc]init];
    }
    return _lblTitle;
}

- (void)setNormalTextColor:(UIColor *)normalTextColor
{
    _normalTextColor = normalTextColor;
    if (normalTextColor) {
        _lblTitle.textColor = normalTextColor;
    }
}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor
{
    _selectedTextColor = selectedTextColor;
}

- (void)setNormalTextFontSize:(CGFloat)normalTextFontSize
{
    _normalTextFontSize = normalTextFontSize;
    _lblTitle.font = [UIFont systemFontOfSize:normalTextFontSize];
}

- (void)setText:(NSString *)text
{
    _lblTitle.text = text;
    [_lblTitle sizeToFit];
    [self resize];
}

- (void)setDidSelected:(BOOL)didSelected
{
    _didSelected = didSelected;
    if (didSelected) {
        _lblTitle.transform = CGAffineTransformScale(CGAffineTransformIdentity, defaultButtonScale, defaultButtonScale);
        _lblTitle.textColor = _selectedTextColor;
    } else {
        _lblTitle.transform = CGAffineTransformIdentity;
        _lblTitle.textColor = _normalTextColor;
    }
}

+ (CGFloat)widthForText:(NSString *)text font:(CGFloat)font space:(CGFloat)space
{
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
    return size.width + space;
}

@end
