//
//  MLControllerCache.h
//  Demo
//
//  Created by WangMengQI on 2017/5/5.
//  Copyright © 2017年 WangMengQI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MLControllerCache : NSObject

- (void)setController:(UIViewController *)controller forKey:(id)key;
- (UIViewController *)controllerForKey:(id)key;

@end
