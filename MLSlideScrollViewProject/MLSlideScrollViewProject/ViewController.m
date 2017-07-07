//
//  ViewController.m
//  MLSlideScrollViewProject
//
//  Created by WangMengQI on 2017/6/21.
//  Copyright © 2017年 WangMengQI. All rights reserved.
//

#import "ViewController.h"
#import "MLViewController.h"
#import "MLSlideHeader.h"

@interface ViewController ()<MLSLideTabViewDataSource, MLSlideTabViewClickDelegte>

@property (nonatomic, strong) MLControllerCache *cache;
@property (nonatomic, strong) MLSlideTabView *tabView;
@property (nonatomic, strong) MLSlideScrollView *slideView;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _titles = @[@"热门", @"科技", @"本地", @"娱乐", @"搞笑", @"车", @"聊天"];
    self.tabView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 40.0);
    self.tabView.normalTextColor = [UIColor colorWithRed:249.0/255.0 green:149.0/255.0 blue:146.0/255.0 alpha:1.0];//RGBCOLOR(249, 149, 146);
    self.tabView.selectedTextColor = [UIColor whiteColor];
    self.tabView.slideView = self.slideView;
    self.tabView.arrTabTitles = _titles;
    self.tabView.initalIndex = 0;
    [self.view addSubview:self.tabView];
    [self.view addSubview:self.slideView];
}


- (UIViewController *)tabControllerAtIndex:(NSInteger)index
{
    return [[MLViewController alloc]init];
}

- (NSInteger)numberControllerInSlideView:(MLSlideScrollView *)slideView
{
    return [_titles count];
}

- (void)tabViewClickIndex:(NSInteger)index
{
    
}

#pragma mark - getter setter
- (MLControllerCache *)cache
{
    if (!_cache) {
        _cache = [[MLControllerCache alloc]init];
    }
    return _cache;
}

- (MLSlideTabView *)tabView
{
    if (!_tabView) {
        _tabView = [[MLSlideTabView alloc]init];
        _tabView.backGroundColor = [UIColor redColor];
        _tabView.dataSource = self;
        _tabView.delegate = self;
    }
    return _tabView;
}

- (MLSlideScrollView *)slideView
{
    if (!_slideView) {
        _slideView = [[MLSlideScrollView alloc]initWithFrame:CGRectMake(0, 40.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.bounds) - 40.0)];
        _slideView.baseViewController = self;
        _slideView.cache = self.cache;
    }
    return _slideView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
