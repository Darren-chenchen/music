//
//  MyAllMusicViewController.m
//  MyqqMusic
//
//  Created by Darren on 15/11/26.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "MyAllMusicViewController.h"
#import "MyAllMusic.h"
#import "UIImage+MJ.h"
#import "MyAllMusicViewCell.h"
#import "MyPlayerViewController.h"

@interface MyAllMusicViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSArray *musicArray;

@property(nonatomic,strong) MyPlayerViewController *playerController;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,weak) UIImageView *rotationImage;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation MyAllMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"全部音乐";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clickCancel)];
    
    // 创建一个tableView
    [self setupTableView];
    
    // 在底部创建一个button用于显示当前正在播放的歌曲
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)];
    btn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 50, 50)];
    imageView.image = [UIImage imageNamed:@"转动"];
    [btn addSubview:imageView];
    self.rotationImage = imageView;
    
    // 放置暂停按钮
    UIButton *btnStop = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)*0.5, 0, 100, 50)];
//    btn.backgroundColor = [UIColor grayColor];
    [btnStop setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    [btnStop setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateSelected];
    [btn addSubview:btnStop];
    [btnStop addTarget:self action:@selector(clickBtnStop:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)clickBtnStop:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.playerController.avPlayer stop];
        [self stopTimer];
    } else{
        [self.playerController.avPlayer play];
        [self starTimer];
    }
    
}

- (void)starTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(imageRotation) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

// 图片转动
- (void)imageRotation
{
    [UIView animateWithDuration:0.5 animations:^{
        self.rotationImage.transform = CGAffineTransformRotate(self.rotationImage.transform, M_PI_4);
    }];

}

- (void)clickBtn
{
//    MyPlayerViewController *player = [[MyPlayerViewController alloc] init];
//    [self presentViewController:player animated:YES completion:nil];
}

/*懒加载*/
- (NSArray *)musicArray
{
    if (_musicArray == nil) {
        NSArray *music = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Musics.plist" ofType:nil]];
        NSMutableArray *mutArr = [NSMutableArray array];
        for (NSDictionary *dict in music) {
            MyAllMusic *allMusic = [MyAllMusic musicWithDict:dict];
            
            [mutArr addObject:allMusic];
        }
        _musicArray = mutArr;
        
    }
    return _musicArray;
}

/*创建一个tableView*/
- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource= self;
    [self.view addSubview:tableView];
    tableView.rowHeight = 60;
}

/*点击取消按钮*/
- (void)clickCancel
{
    [self.playerController.avPlayer stop];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.musicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyAllMusicViewCell *cell = [MyAllMusicViewCell cellWithTableView:tableView];
    
    cell.allMusic = self.musicArray[indexPath.row];
    
    return cell;
}

// 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 跳转到音乐播放控制器
    if (self.index != indexPath.row) {
        [self.playerController.avPlayer stop];
        [self stopTimer];
        [self starTimer];
        self.playerController = [[MyPlayerViewController alloc] init];
    } else if (indexPath.row == 0){
        self.playerController = [[MyPlayerViewController alloc] init];
    }
    
    self.index = indexPath.row;
    self.playerController.index = indexPath.row;
    self.playerController.musicArr  = self.musicArray;
    [self presentViewController:self.playerController animated:YES completion:nil];
}



@end
