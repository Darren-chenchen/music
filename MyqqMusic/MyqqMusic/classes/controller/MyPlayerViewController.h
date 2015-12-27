//
//  MyPlayerViewController.h
//  MyqqMusic
//
//  Created by Darren on 15/11/26.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAllMusic.h"
#import <AVFoundation/AVFoundation.h>


@interface MyPlayerViewController : UIViewController

@property(nonatomic,strong) AVAudioPlayer *avPlayer;

//@property(nonatomic,strong)MyAllMusic *allMusic;
@property (nonatomic,strong) NSArray *musicArr;  // 数组中存放所有歌曲的模型
@property (nonatomic,assign) NSInteger index; // 对应的下标

//@property (nonatomic,weak) id<MyPlayerViewControllerDataSource>dataSource;


@end
