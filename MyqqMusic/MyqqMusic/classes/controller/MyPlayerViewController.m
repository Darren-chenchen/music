//
//  MyPlayerViewController.m
//  MyqqMusic
//
//  Created by Darren on 15/11/26.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "MyPlayerViewController.h"
#import "UIView+Extension.h"
#import <AVFoundation/AVFoundation.h>
#import "MyAllMusic.h"
#import "UIImage+MJ.h"
#import "MyLrcTableViewCell.h"

@interface MyPlayerViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong) NSTimer *timer2;
@property (nonatomic,strong) CADisplayLink *timerLrc;
@property (weak, nonatomic) IBOutlet UIProgressView *progess;
@property (weak, nonatomic) IBOutlet UIButton *beginBtn;

@property (nonatomic,strong) NSArray *lycArr;
@property (nonatomic,strong) NSArray *lycTimerArr;

- (IBAction)hiddenPlayer;
- (IBAction)beginOrPause:(UIButton *)btn;  // 点击开始或暂停
- (IBAction)nextMusic;
@property (weak, nonatomic) IBOutlet UIButton *nextMusicBtn;
@property (weak, nonatomic) IBOutlet UIButton *previousMusicBtn;

- (IBAction)previousMusic;

@property (weak, nonatomic) IBOutlet UILabel *beginLable;
@property (weak, nonatomic) IBOutlet UILabel *endLable;
@property (weak, nonatomic) IBOutlet UIImageView *rotationImage;
- (IBAction)clickVolume:(UIButton *)btn;   // 点击音量调节
@property (weak, nonatomic) IBOutlet UIButton *volume;
@property (weak, nonatomic) IBOutlet UIImageView *playerBj;
@property (weak, nonatomic) IBOutlet UIView *volumeChange;
@property (weak, nonatomic) IBOutlet UISlider *volumeChangeSlider;
- (IBAction)changeVolume;

@property (weak, nonatomic) IBOutlet UILabel *singer;
@property (weak, nonatomic) IBOutlet UILabel *songName;
@property (weak, nonatomic) IBOutlet UITableView *lycTableView;
- (IBAction)lyricBtn:(UIButton *)sender;

@property (nonatomic,weak) UIView *coverView;
@property (nonatomic,assign) int currentIndex;


@end

@implementation MyPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置圆盘
    self.rotationImage.image = [UIImage circleImageWithName:@"转动" borderWidth:0 borderColor:[UIColor redColor]];
    [self startTimer2];
    
    // 设置url
    [self setupUrl];

    self.beginBtn.selected = YES; // 设置一开始按钮的状态就是选中状态
    [self startTimer];
    
    // 设置总时长的lable显示
    [self setEndlableTime];
    
    // 设置的代理和数据源
    self.lycTableView.delegate = self;
    self.lycTableView.dataSource = self;
    self.lycTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.lycTableView.contentInset = UIEdgeInsetsMake(self.lycTableView.height * 0.5, 0, self.lycTableView.height * 0.5, 0);
    
    // 开启歌词的定时器
    [self startLrcTime];
}

/**开启歌词定时器*/
- (void)startLrcTime
{
    self.timerLrc = [CADisplayLink displayLinkWithTarget:self selector:@selector(upDateLrc)];
    [self.timerLrc addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopLrcTime
{
    [self.timerLrc invalidate];
    self.timerLrc = nil;
}
- (void)upDateLrc
{
    [self setcurrentTime:self.avPlayer.currentTime];
}

/**歌词懒加载*/
- (NSArray *)lycArr
{
    if (_lycArr == nil) {
        _lycArr = [NSArray array];
    }
    return _lycArr;
}

/**设置总时长显示*/
- (void)setEndlableTime
{
    int endLableMinum = self.avPlayer.duration/60;
    int endLablemiao = (int)self.avPlayer.duration%60;
    self.endLable.text = [NSString stringWithFormat:@"%02d:%02d",endLableMinum,endLablemiao];
    self.endLable.textColor = [UIColor redColor];
}

/**圆盘转动*/
- (void)rotation
{
    [UIView animateWithDuration:0.5 animations:^{
        self.rotationImage.transform = CGAffineTransformRotate(self.rotationImage.transform, M_PI_4/8);
    }];
}

/**初始化文件的路径*/
- (void)setupUrl
{
        
    MyAllMusic *allMusic = self.musicArr[self.index];
    self.playerBj.image = [UIImage imageNamed:allMusic.icon];
    self.singer.text = allMusic.singer;
    self.songName.text = allMusic.name;
    // 歌词
    NSURL *urlLyc = [[NSBundle mainBundle] URLForResource:allMusic.lrcname withExtension:nil];
    NSString *lrcStr = [NSString stringWithContentsOfURL:urlLyc encoding:NSUTF8StringEncoding error:nil];
    NSArray *lrcArray = [lrcStr componentsSeparatedByString:@"\n"];
    
    // 取出不含时间的文字
    NSMutableArray *mutArr = [NSMutableArray array];
    NSMutableArray *mutArr2 = [NSMutableArray array];
    for (NSString *lrc in lrcArray) {
        NSArray *titleArr = [lrc componentsSeparatedByString:@"]"];
        [mutArr addObject:[titleArr lastObject]];
        [mutArr2 addObject:titleArr[0]];
    }
    self.lycArr = mutArr;   // 数组中存放着不含时间的文字

    // 取出时间
    NSMutableArray *mutArr3 = [NSMutableArray array];
    for (int i = 0; i < mutArr2.count-1; i++) {
        NSString *lrctimer = mutArr2[i];
        NSString *lyr = [lrctimer substringFromIndex:1];
        [mutArr3 addObject:lyr];
    }
    self.lycTimerArr = mutArr3;  // 数组中存放着时间

    NSURL *url = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:allMusic.filename ofType:nil]];
    [self music:url];
}

/**创建音乐*/
- (void)music:(NSURL *)url
{
    self.avPlayer = nil;
    self.avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.avPlayer.volume = 0.5;
    [self.avPlayer play];
}

- (IBAction)hiddenPlayer {
//    self.allMusicController.buttomBtn.userInteractionEnabled = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**启动定时器控制圆盘转动*/
- (void)startTimer2
{
    self.timer2 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(rotation) userInfo:nil repeats:YES];
    [self.timer2 fire];
}

/**停止定时器2*/
- (void)stopTimer2
{
    [self.timer2 invalidate];
    self.timer2 = nil;
}

/**启动定时器*/
- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(music) userInfo:nil repeats:YES];
    [self.timer fire];
}

/**关闭定时器*/
- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

/**
 *启动定时器后每隔一段时间来到这个方法，取到当前时间
 */
- (void)music
{
    self.progess.progress = self.avPlayer.currentTime/self.avPlayer.duration;
    [self strWithTime:self.avPlayer.currentTime];

    
}
- (void)setcurrentTime:(NSTimeInterval)currentTime
{
    // 当前播放的时间
    int minute = currentTime / 60;
    int second = (int)currentTime % 60;
    int msecond = (currentTime - (int)currentTime) * 100;
    NSString *currentTimeStr = [NSString stringWithFormat:@"%02d:%02d.%02d", minute, second, msecond];
    
      NSInteger count = self.lycTimerArr.count;
    for (int index = self.currentIndex + 1; index<count; index++) {

        // 时间数组中每行的时间
        NSString *currentLineTime = self.lycTimerArr[index];
        // 下一行的时间
        NSString *nextLineTime = nil;
        NSUInteger nextIdx = index + 1;
        if (nextIdx < self.self.lycTimerArr.count) {
            nextLineTime = self.lycTimerArr[nextIdx];
        }

        // 判断是否为正在播放的歌词
        if (
            // 比较大小，NSOrderedAscending升序
            ([currentTimeStr compare:currentLineTime] != NSOrderedAscending)
            && ([currentTimeStr compare:nextLineTime] == NSOrderedAscending)
            && self.currentIndex != index) {
            // 刷新tableView
            NSArray *reloadRows = @[
                                    [NSIndexPath indexPathForRow:self.currentIndex inSection:0],
                                    [NSIndexPath indexPathForRow:index inSection:0]
                                    ];
            self.currentIndex = index;
            [self.lycTableView reloadRowsAtIndexPaths:reloadRows withRowAnimation:UITableViewRowAnimationNone];
            
            // 滚动到对应的行
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            [self.lycTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
    
}

/**走过的时间*/
- (void)strWithTime:(NSTimeInterval)time
{
    int minute=time / 60;
    int second=(int)time % 60;
    self.beginLable.text = [NSString stringWithFormat:@"%02d:%02d",minute,second];
    self.beginLable.textColor = [UIColor redColor];
}

// 点击开始或暂停来到这个方法
- (IBAction)beginOrPause:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        [self startTimer];   // 开始播放启动定时器
        [self startTimer2];
        [self startLrcTime];
        [self.avPlayer play];
        
    } else {
        [self stopTimer];  // 暂停后关闭定时器
        [self stopTimer2];
        [self stopLrcTime];
        [self.avPlayer pause];
    }
}

/*点击下一首*/
- (IBAction)nextMusic {
    self.currentIndex = 0;
    if (!self.beginBtn.selected) {  // 如果是暂停状态按下一首：就让按钮状态改变，同时开启定时器
        self.beginBtn.selected = YES;
        [self startTimer];
    }
    [self.avPlayer stop];
//    MyAllMusic *allMusic = self.musicArr[self.index];
//    allMusic.lrcname = nil;
    self.index ++;
//    NSLog(@"%ld",self.index);
    if (self.index == 9) {
        self.index = 0;
    }

    
    [self setupUrl];
    [self.lycTableView reloadData];
}

/**上一首*/
- (IBAction)previousMusic {
    self.currentIndex = 0;
    if (!self.beginBtn.selected) {  // 如果是暂停状态按下一首：就让按钮状态改变，同时开启定时器
        self.beginBtn.selected = YES;
        [self startTimer];
    }
    [self.avPlayer stop];
    self.index --;
    if (self.index == -1) {
        self.index = 8;
    }
    [self setupUrl];
    [self.lycTableView reloadData];


}

// 调节音量
- (IBAction)clickVolume:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    if (btn.selected) {
        [UIView animateWithDuration:0.5 animations:^{
            self.volumeChange.alpha = 1;
            self.volumeChangeSlider.alpha = 1;
        }];
    } else{
        [UIView animateWithDuration:0.5 animations:^{
            self.volumeChange.alpha = 0;
            self.volumeChangeSlider.alpha = 0;
        }];

    }
}
- (IBAction)changeVolume {
    self.avPlayer.volume = self.volumeChangeSlider.value;
}

// 控制歌词界面显示
- (IBAction)lyricBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [UIView animateWithDuration:0.5 animations:^{
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-62)];
            view.alpha = 0.7;
            view.backgroundColor = [UIColor yellowColor];
            [self.playerBj addSubview:view];
            self.coverView = view;
            self.lycTableView.alpha = 1;
            self.lycTableView.alpha = 0.7;
        }];
    } else{
        [UIView animateWithDuration:0.5 animations:^{
            self.coverView.alpha = 0;
            self.lycTableView.alpha = 0;
        }];
    }
}

#pragma mark - 数据源方法
// 1.多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 2.组对应的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lycArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell"; // 只分配一次内存空间
    MyLrcTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[MyLrcTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lrcLable.text = self.lycArr[indexPath.row];
    if(self.currentIndex == indexPath.row){
        cell.lrcLable.font = [UIFont systemFontOfSize:20];
        cell.lrcLable.textColor = [UIColor redColor];
    } else {
        cell.lrcLable.font = [UIFont systemFontOfSize:15];
        cell.lrcLable.textColor = [UIColor blackColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.lycTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

@end
