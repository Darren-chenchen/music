//
//  MovePlayerViewController.m
//  MyqqMusic
//
//  Created by Darren on 15/11/27.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "MovePlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "MyPlayerViewController.h"

@interface MovePlayerViewController ()

@property (nonatomic, strong) MPMoviePlayerController *playerController;

@end

@implementation MovePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clickCancel)];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"mv" ofType:@"mp4"];
    
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    
    self.playerController = [[MPMoviePlayerController alloc] initWithContentURL:url];
    self.playerController.view.frame = CGRectMake(0, 100, self.view.frame.size.width, 200);//视频视图大小
    
    [self.view addSubview:self.playerController.view];//把视频界面加到主界面上
    
    [self.playerController play];
    

}

- (void)clickCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
