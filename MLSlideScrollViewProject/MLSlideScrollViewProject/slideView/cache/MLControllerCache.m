//
//  MLControllerCache.m
//  Demo
//
//  Created by WangMengQI on 2017/5/5.
//  Copyright © 2017年 WangMengQI. All rights reserved.
//

#import "MLControllerCache.h"

@interface MLControllerCache()

@property (nonatomic, strong) NSMutableDictionary *cache;

@end

@implementation MLControllerCache

- (void)setController:(UIViewController *)controller forKey:(id)key
{
    [self.cache setObject:controller forKey:key];
}

- (UIViewController *)controllerForKey:(id)key
{
    return [self.cache objectForKey:key];
}

#pragma mark - getter setter
- (NSMutableDictionary *)cache
{
    if (!_cache) {
        _cache = [[NSMutableDictionary alloc]init];
    }
    return _cache;
}

@end
