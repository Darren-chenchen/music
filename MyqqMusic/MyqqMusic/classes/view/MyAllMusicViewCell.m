//
//  MyAllMusicViewCell.m
//  MyqqMusic
//
//  Created by Darren on 15/11/26.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "MyAllMusicViewCell.h"
#import "UIImage+MJ.h"
#import "MyAllMusic.h"

@implementation MyAllMusicViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    static NSString *ID = @"cell";
    MyAllMusicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MyAllMusicViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;

}

- (void)setAllMusic:(MyAllMusic *)allMusic
{
    _allMusic  = allMusic;
    self.imageView.image = [UIImage circleImageWithName:allMusic.singerIcon borderWidth:3 borderColor:[UIColor blueColor]];
    self.textLabel.text = allMusic.name;
    self.detailTextLabel.text = allMusic.singer;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
