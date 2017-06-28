# MLSlideView

将slideView文件夹复制到项目中，在使用的类中添加头文件，#import "MLSlideHeader.h"
在- (void)viewDidLoad中
``` _titles = @[@"热门", @"科技", @"本地", @"娱乐", @"搞笑", @"车", @"聊天"];
   self.tabView.normalTextColor = [UIColor colorWithRed:249.0/255.0 green:149.0/255.0 blue:146.0/255.0 alpha:1.0];//RGBCOLOR(249, 149, 146);
   self.tabView.selectedTextColor = [UIColor whiteColor];
   self.tabView.slideView = self.slideView;
   self.tabView.arrTabTitles = _titles;
   self.tabView.initalIndex = 0;
   [self.view addSubview:self.tabView];
   [self.view addSubview:self.slideView];
  
  
  实现MLSLideTabViewDataSource, MLSlideTabViewClickDelegte代理方法
  这个是返回index对应的Controller
  ```
  - (UIViewController *)tabControllerAtIndex:(NSInteger)index
  {
      return [[MLViewController alloc]init];
  }
  
这个是返回tab的count
```
- (NSInteger)numberControllerInSlideView:(MLSlideScrollView *)slideView
{
    return [_titles count];
}

这个是点击每个tab的回调
```
- (void)tabViewClickIndex:(NSInteger)index
{
    
}
