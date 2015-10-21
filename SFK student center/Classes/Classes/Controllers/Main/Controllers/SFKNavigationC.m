//
//  SFKNavigationC.m
//  SFK student center
//
//  Created by Jeemy on 15/10/20.
//  Copyright © 2015年 SKF. All rights reserved.
//

#import "SFKNavigationC.h"

@interface SFKNavigationC ()

@end

@implementation SFKNavigationC


//+ (void)initialize{
//    
//    // 设置整个项目所有item的主题样式
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    
//    // 设置普通状态
//    // key：NS****AttributeName
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
//    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
//    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    
//    // 设置不可用状态
//    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
//    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
//    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
//    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationBar.backgroundColor=[UIColor blackColor];
//    self.navigationBar.tintColor=[UIColor blueColor];
//    [self.navigationBar setOpaque:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
