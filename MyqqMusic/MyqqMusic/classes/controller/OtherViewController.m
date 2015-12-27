//
//  OtherViewController.m
//  MyqqMusic
//
//  Created by Darren on 15/11/27.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController ()

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,weak) UILabel *lable;

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dismis) userInfo:nil repeats:YES];
    
    UILabel *lable = [[UILabel alloc] init];
    lable.frame = CGRectMake((self.view.frame.size.width-100)*0.5, (self.view.frame.size.height-100)*0.5, 100, 100);
    lable.text = @"3";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:70];
    [self.view addSubview:lable];
    self.lable = lable;
}

- (void)dismis
{
    int a = [self.lable.text intValue];
    a--;
    self.lable.text = [NSString stringWithFormat:@"%d",a];
    if (a==0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
