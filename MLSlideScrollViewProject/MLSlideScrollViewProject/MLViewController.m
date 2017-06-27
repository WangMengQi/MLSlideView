//
//  MLViewController.m
//  MLSlideScrollViewProject
//
//  Created by WangMengQI on 2017/6/21.
//  Copyright © 2017年 WangMengQI. All rights reserved.
//

#import "MLViewController.h"

@interface MLViewController ()

@end

@implementation MLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    int r = arc4random() % 250;
    int g = arc4random() % 250;
    int b = arc4random() % 250;
    self.view.backgroundColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
