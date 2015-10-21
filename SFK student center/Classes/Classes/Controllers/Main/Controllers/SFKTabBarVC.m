//
//  SFKTabBarVC.m
//  SFK student center
//
//  Created by Jeemy on 15/10/20.
//  Copyright © 2015年 SKF. All rights reserved.
//

#import "SFKTabBarVC.h"
#import "HomepageVC.h"
#import "UploadManageVC.h"
#import "CourseScheduleTVC.h"
#import "SFKNavigationC.h"

@interface SFKTabBarVC ()

@end

@implementation SFKTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
   //1.初始化子控制器
    
    HomepageVC *home = [[HomepageVC alloc] init];
    [self addChildVc:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    UploadManageVC *upMana = [[UploadManageVC alloc] init];
    [self addChildVc:upMana title:@"上传管理" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    CourseScheduleTVC *courseSche = [[CourseScheduleTVC alloc] init];
    [self addChildVc:courseSche title:@"课时进度" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    
    //2.设置代理，实现tabBar切换动画效果的方法
    self.delegate=self;
    
    //3.设置tabBar背景颜色
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 420, 49)];
    backView.backgroundColor = [UIColor darkGrayColor];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    //    self.tabBar.opaque=YES;
//            [self.tabBar setBarTintColor:[UIColor colorWithRed:144 green:144 blue:144 alpha:0]];
            [self.tabBar setBackgroundColor:[UIColor colorWithRed:22 green:22 blue:22 alpha:0]];
//    self.tabBarController.tabBar.backgroundColor=[UIColor blackColor];
    
    //4.设置导航条
    // 获取所有导航条外观
//    UINavigationBar *bar = [UINavigationBar appearance];
//    
//    UIImage *navImage = [[UIImage alloc]init];
//    if (IOS7) {
//        navImage = [UIImage imageNamed:@"NavBar64"];
//    }else{
//        navImage = [UIImage imageNamed:@"NavBar"];
//    }
//         [bar setBackgroundImage:navImage forBarMetrics:UIBarMetricsDefault];
    

}


- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    //    childVc.tabBarItem.title = title; // 设置tabbar的文字
    //    childVc.navigationItem.title = title; // 设置navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    
#pragma mark  －－－－此处设置属性未生效，原因待查。另导航栏和tabBar颜色设定用系统的不行，考虑设image背景
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = JSColor(255, 255, 255);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];

    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
//    childVc.view.backgroundColor = JSRandomColor;
    childVc.view.backgroundColor=JSColor(25, 25, 25);
#pragma mark －－－－没生效可用appearance，get所有Item项目外观，则字体颜色可设置
    [[UITabBarItem appearance]setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [[UITabBarItem appearance]setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
//    [[UINavigationBar appearance] setBackgroundColor:[UIColor blackColor]];
//    
//    [[UITabBar appearance]setBackgroundColor:[UIColor blackColor]];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    SFKNavigationC *nav = [[SFKNavigationC alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController*)viewController
{
    JSLog(@"___________________________tabBar动画切换");
    //[UIView beginAnimations:nil context:nil];
    //[UIView setAnimationDuration:1];
    //[UIView setAnimationBeginsFromCurrentState:NO];
    //[UIView setAnimationCurve:UIViewAnimationTransitionFlipFromLeft];
    //[UIView setAnimationTransition:kCATransitionMoveIn forView:tabBarController.view cache:YES];
    //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:viewController.view cache:NO];
    //[viewController.view removeFromSuperview];
    //[UIView commitAnimations];
    CATransition *animation =[CATransition animation];
    [animation setDuration:0.4f];
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromTop];
    [tabBarController.view.layer addAnimation:animation forKey:@"reveal"];
    
    return YES;
}

@end
