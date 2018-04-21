//
//  GuideViewController.m
//  MBProject
//
//  Created by MaBiao on 2018/4/21.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIPageControl *pageControl;

@property (nonatomic,strong)UIScrollView *guideScrollView;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

///单例
+ (instancetype)shareXTGuideVC
{
    static GuideViewController *x = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        x = [[GuideViewController alloc] init];
    });
    return x;
}

///进入按钮点击
- (void)clickEnter:(UIButton *)sender
{
    self.guideScrollView.transform = CGAffineTransformMakeScale(1, 1);
    self.guideScrollView.alpha = 1;
    
    [UIView animateWithDuration:0.7 animations:^{
        self.guideScrollView.alpha = 0.05;
        self.guideScrollView.transform = CGAffineTransformMakeScale(5, 5);
        
    } completion:^(BOOL finished) {
        
        [self.guideScrollView removeFromSuperview];
        
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(guideVCBtnAction:)]) {
            [self.delegate guideVCBtnAction:sender];
        }
    }];
}

///根据版本信息是否展示
- (BOOL)isShow
{
    // 读取版本信息
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *localVersion = [user objectForKey:@"new"];
    NSString *currentVersion =[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"L ===%@", localVersion);
    NSLog(@"C ===%@", currentVersion);
    if (localVersion == nil || ![currentVersion isEqualToString:localVersion]) {
        [self saveCurrentVersion];
        return YES;
    }else{
        return NO;
    }
}
/// 保存版本信息
- (void)saveCurrentVersion
{
    NSString *version =[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:version forKey:@"new"];
    [user synchronize];
}

///初始化
- (void)initWithXTGuideView:(NSArray *)images
{
    UIScrollView *guideScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    guideScrollView.pagingEnabled = YES;
    // 隐藏滑动条
    guideScrollView.showsHorizontalScrollIndicator = NO;
    guideScrollView.showsVerticalScrollIndicator = NO;
    // 取消反弹
    guideScrollView.bounces = NO;
    for (NSInteger i = 0; i < images.count; i ++) {
        [guideScrollView addSubview:({
            self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth * i, 0, ScreenWidth, ScreenHeight)];
            self.imageView.image = [UIImage imageNamed:images[i]];
            self.imageView;
        })];
        
        self.imageView.userInteractionEnabled = YES;
        
        if (i == images.count - 1){
            self.imageView.backgroundColor = [UIColor yellowColor];
            ///最后一页
            [self.imageView addSubview:({
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setTitle:@"立即体验" forState:UIControlStateNormal];
                btn.frame = CGRectMake(ScreenWidth * i, ScreenHeight - 60, 100, 40);
                btn.center = CGPointMake(ScreenWidth / 2, ScreenHeight - 60);
                btn.backgroundColor = [UIColor lightGrayColor];
                [btn addTarget:self action:@selector(clickEnter:) forControlEvents:UIControlEventTouchUpInside];
                btn;
            })];
        }else{///其他页面，直接进入
            [self.imageView addSubview:({
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setTitle:@"点击进入" forState:UIControlStateNormal];
                btn.frame = CGRectMake(ScreenWidth * i, ScreenHeight - 60, 100, 40);
                btn.center = CGPointMake(ScreenWidth / 2, ScreenHeight - 60);
                btn.backgroundColor = [UIColor lightGrayColor];
                [btn addTarget:self action:@selector(clickEnter:) forControlEvents:UIControlEventTouchUpInside];
                btn;
            })];
        }
    }
    guideScrollView.contentSize = CGSizeMake(ScreenWidth * images.count, 0);
    guideScrollView.delegate = self;
    [self.view addSubview:guideScrollView];
    self.guideScrollView = guideScrollView;
    
    // pageControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth / 2, 30)];
    self.pageControl.center = CGPointMake(ScreenWidth / 2, ScreenHeight - 95);
    [self.view addSubview:self.pageControl];
    self.pageControl.numberOfPages = images.count;
}

#pragma mark - ScrollerView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    if(offset.x<=0){
        offset.x = 0;
        scrollView.contentOffset = offset;
    }
    NSUInteger index = round(offset.x / scrollView.frame.size.width);
    self.pageControl.currentPage = index;
}

@end
