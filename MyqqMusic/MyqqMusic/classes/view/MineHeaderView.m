//
//  MineHeaderView.m
//  MyqqMusic
//
//  Created by Darren on 15/11/25.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "MineHeaderView.h"
#import "MineCustomButton.h"


@implementation MineHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 放置6个按钮
        [self addSubButtons];
        
        // 再放置一个lable
        [self addGuessYouLike];
    }
    return self;
}

// 放置6个按钮
- (void)addSubButtons
{
    NSArray *array = @[@"全部歌曲",@"全部视屏",@"我喜欢",@"下载MV",@"最近播放",@"听歌识曲"];
    CGFloat magin = 20;
    CGFloat btnW = ([UIScreen mainScreen].bounds.size.width-4*magin)/3;
    CGFloat btnH = btnW;
    for (int i =0; i<6; i++) {
        MineCustomButton *btn = [[MineCustomButton alloc] init];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"main_%02d",i]] forState:UIControlStateNormal];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        CGFloat row = i / 3;
        CGFloat arrange = i % 3;
        CGFloat btnX = magin + (magin + btnW)*arrange;
        CGFloat btnY = (magin+btnH) *row;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
//        btn.backgroundColor = [UIColor redColor];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

// 猜你喜欢
- (void)addGuessYouLike
{
    UIButton *guessLable = [[UIButton alloc] initWithFrame:CGRectMake(0, 240, [UIScreen mainScreen].bounds.size.width, 50)];
    [guessLable setTitle:@"猜你喜欢" forState:UIControlStateNormal];
    guessLable.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [guessLable setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [guessLable setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    guessLable.backgroundColor = [UIColor whiteColor];
//    [guessLable addTarget:self action:@selector(clickGuess) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:guessLable];
}

// 监听按钮点击
- (void)clickBtn:(UIButton *)btn
{
    if (btn.tag == 100) { // 点击了全部歌曲按钮
        [self.delegate devideButton:btn];
    } else if (btn.tag == 101){
        [self.delegate devideButton:btn];
    } else {
        [self.delegate devideButton:btn];
    }
}

@end
