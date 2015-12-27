//
//  CeBianLanViewController.m
//  MyqqMusic
//
//  Created by Darren on 15/12/5.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CeBianLanViewController.h"
#import "UIView+Extension.h"

@interface CeBianLanViewController ()

@end

@implementation CeBianLanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];

    
}

- (void)show
{
    // 0.禁用整个app的点击事件
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    window.userInteractionEnabled = NO;
    
    // 1.添加播放界面
    self.view.frame = window.bounds;
    self.view.hidden = NO;
    [window addSubview:self.view];
    
    // 3.动画显示
    self.view.width = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.view.width = [UIScreen mainScreen].bounds.size.width-50;
    } completion:^(BOOL finished) {
        
        window.userInteractionEnabled = YES;
    }];
}
- (void)click
{
    //0.禁用整个app的点击事件
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    window.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.width = 0;
    } completion:^(BOOL finished) {
        self.view.hidden = YES;
        window.userInteractionEnabled = YES;
    }];
}

@end
