//
//  HomepageVC.m
//  SFK student center
//
//  Created by Jeemy on 15/10/20.
//  Copyright © 2015年 SKF. All rights reserved.
//

#import "HomepageVC.h"

@interface HomepageVC ()

@end

@implementation HomepageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    /* 设置导航栏上面的内容 */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(headIcon) image:@"" highImage:@""];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(homeMessage) image:@"" highImage:@""];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = JSColor(255, 255, 255);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    
    //设置首页图片View
  
    
    
}

-(void)headIcon{
    JSLog(@"____________________您点击了头像");
}
-(void)homeMessage{
    JSLog(@"_____________________您点击了消息");
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
