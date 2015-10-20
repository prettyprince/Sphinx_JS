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
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = JSColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    childVc.view.backgroundColor = JSRandomColor;
    
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
