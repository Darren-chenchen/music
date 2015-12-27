//
//  MyAllMusicViewCell.h
//  MyqqMusic
//
//  Created by Darren on 15/11/26.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyAllMusic;

@interface MyAllMusicViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong) MyAllMusic *allMusic;

@end
