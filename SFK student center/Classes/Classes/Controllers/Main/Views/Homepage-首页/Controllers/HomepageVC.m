//
//  HomepageVC.m
//  SFK student center
//
//  Created by Jeemy on 15/10/20.
//  Copyright © 2015年 SKF. All rights reserved.
//

#import "HomepageVC.h"
#import "ActivitiesTVC.h"

#define jsImageCount     5
@interface HomepageVC ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic ,strong)ActivitiesTVC *actTVC;
@end

@implementation HomepageVC

/**
 *设置滚动view和pageControl的懒加载方法
 */
- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame=CGRectMake(10,70, 100, 200);
        //这里如果用imageView从故事版拖过来，frame是拖过来时屏幕尺寸的规格，如果换了屏幕尺寸，还是不会变,要在当ViewWillApearance才变化。
        if (iPhone5) {
            _scrollView.frame=CGRectMake(5, 71, 310, 199);
            JSLog(@"运行到iphone5上");
        }else if(iPhone6){
              _scrollView.frame=CGRectMake(5, 71, 365, 248.5);
        }else{
           _scrollView.frame=self.imageView.frame;
        }
        _scrollView.backgroundColor = [UIColor redColor];
        
        [self.view addSubview:_scrollView];
        
        // 取消弹簧效果
        _scrollView.bounces = NO;
        
        // 取消水平滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        // 要分页
        _scrollView.pagingEnabled = YES;
        
        // contentSize
        _scrollView.contentSize = CGSizeMake(jsImageCount * _scrollView.bounds.size.width, 0);
        
        // 设置代理
        _scrollView.delegate = self;
    }
    return _scrollView;
}
- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        // 分页控件，本质上和scrollView没有任何关系，是两个独立的控件
        _pageControl = [[UIPageControl alloc] init];
        // 总页数
        _pageControl.numberOfPages = jsImageCount;
        // 控件尺寸
        CGSize size = [_pageControl sizeForNumberOfPages:jsImageCount];
        
        _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
        _pageControl.center = CGPointMake((self.view.center.x+95), (self.scrollView.frame.size.height+50));
        
        // 设置颜色
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        
        [self.view addSubview:_pageControl];
        
        // 添加监听方法
        /** 在OC中，绝大多数"控件"，都可以监听UIControlEventValueChanged事件，button除外" */
        [_pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}
// 分页控件的监听方法
- (void)pageChanged:(UIPageControl *)page
{
//    NSLog(@"%ld", page.currentPage);
    
    // 根据页数，调整滚动视图中的图片位置 contentOffset
    CGFloat x = page.currentPage * self.scrollView.bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    JSLog(@"加载视图时self.imageview.frame=%f",self.imageView.frame.size.width);
//    _scrollView.frame=self.imageView.frame;
    
    /* 设置导航栏上面的内容 */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(headIcon) image:@"" highImage:@""];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(homeMessage) image:@"" highImage:@""];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = JSColor(255, 255, 255);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    
    //设置首页图片滚动view
    self.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"img_02"]];
    [self imageScrollSet];
    //滚动view点击事件
    
    
}

/**
 *设置轮播图片
 */
-(void)imageScrollSet{
    // 设置图片
    for (int i = 0; i < jsImageCount; i++) {
        //IMG_0001.JPG  img_%02d , i + 1
        NSString *imageName = [NSString stringWithFormat:@"img_%02d",i+1];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame=self.scrollView.bounds;
        imageView.image=image;
        [self.scrollView addSubview:imageView];
        
        [self scrollViewClick:imageView];
    }
    
    // 计算imageView的位置
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
        
        // 调整x => origin => frame
        CGRect frame = imageView.frame;
        frame.origin.x = idx * frame.size.width;
        
        imageView.frame = frame;
    }];
    //    NSLog(@"%@", self.scrollView.subviews);
    
    // 分页初始页数为0
    self.pageControl.currentPage = 0;
    
    // 启动时钟
    [self startTimer];
}

//当约束控件进行屏幕变更时，只有在进行到这里frame才会改变.
-(void)viewDidAppear:(BOOL)animated{
//    self.scrollView.frame=self.imageView.frame;
    JSLog(@"视图要显示时self.imageview.frame=%f",self.imageView.frame.size.width);
}
/**
 *头像点击
 */
-(void)headIcon{
    JSLog(@"____________________您点击了头像");
}

/**
 *右上角信息点击
 */
-(void)homeMessage{
    JSLog(@"_____________________您点击了消息");
}

/**
 *时间计时
 */
- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}

/**
 *滚动更新
 */
- (void)updateTimer
{
    // 页号发生变化
    // (当前的页数 + 1) % 总页数
    int page = (self.pageControl.currentPage + 1) % jsImageCount;
    self.pageControl.currentPage = page;
    
//    JSLog(@"%ld", self.pageControl.currentPage);
    // 调用监听方法，让滚动视图滚动
    [self pageChanged:self.pageControl];
}

#pragma mark - ScrollView的代理方法
// 滚动视图停下来，修改页面控件的小点（页数）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 停下来的当前页数
//    NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
    
    // 计算页数
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    self.pageControl.currentPage = page;
}

/**
 *手指点击事件
 */
-(void)scrollViewClick:(UIImageView *)imageView{
    
    //为了能响应多手势事件，imageView的userInteractionEnabled属性要设为YES.
    imageView.userInteractionEnabled=YES;
    
    //1、手指点击事件
    //单指单击
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(fingerIncident:)];
    //手指数
    singleFingerOne.numberOfTouchesRequired = 1;
    //点击次数
    singleFingerOne.numberOfTapsRequired = 1;
    //设置代理方法
    singleFingerOne.delegate= self;
    //增加事件者响应者，
    [imageView addGestureRecognizer:singleFingerOne];
    
    //单指双击
    UITapGestureRecognizer *singleFingerTwo =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(fingerIncident:)];
    singleFingerTwo.numberOfTouchesRequired = 1;
    singleFingerTwo.numberOfTapsRequired = 2;
    singleFingerTwo.delegate= self;
    [imageView addGestureRecognizer:singleFingerTwo];
    
    
    //双指单击
    UITapGestureRecognizer *doubleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(fingerIncident:)];
    doubleFingerOne.numberOfTouchesRequired = 2;
    doubleFingerOne.numberOfTapsRequired = 1;
    doubleFingerOne.delegate= self;
    [self.imageView addGestureRecognizer:doubleFingerOne];
    
    //双指双击
    UITapGestureRecognizer *doubleFingerTwo = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(fingerIncident:)];
    doubleFingerTwo.numberOfTouchesRequired = 2;
    doubleFingerTwo.numberOfTapsRequired = 2;
    doubleFingerTwo.delegate= self;
    [self.imageView addGestureRecognizer:doubleFingerTwo];
    
    //如果不加下面的话，当单指双击时，会先调用单指单击中的处理，再调用单指双击中的处理
    [singleFingerOne requireGestureRecognizerToFail:singleFingerTwo];
    //同理双指也是如此
    [doubleFingerOne requireGestureRecognizerToFail:doubleFingerTwo];
    
}

//手指点击事件
- (void)fingerIncident:(UITapGestureRecognizer *)sender
{
    if (sender.numberOfTouchesRequired==1) {
        //单指点击事件
        if(sender.numberOfTapsRequired == 1) {
            //单指单击
            NSLog(@"单指单击");
            [sender.view.layer removeAllAnimations];
            //跳转控制器
            self.actTVC=[[ActivitiesTVC alloc]init];
//             self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:self.actTVC animated:YES];
        }
        else if(sender.numberOfTapsRequired ==2 ){
            //单指双击
            NSLog(@"单指双击");
        }
    }
    else if (sender.numberOfTouchesRequired==2) {
        //双指点击事件
        if(sender.numberOfTapsRequired == 1) {
            //双指单击
            NSLog(@"双指单击");
        }
        else if(sender.numberOfTapsRequired ==2 ){
            //双指双击
            NSLog(@"双指双击");
        }
    }
}



@end
