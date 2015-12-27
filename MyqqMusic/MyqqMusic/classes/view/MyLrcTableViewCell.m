//
//  MyLrcTableViewCell.m
//  MyqqMusic
//
//  Created by Darren on 15/11/28.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "MyLrcTableViewCell.h"

@implementation MyLrcTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.lrcLable = [[UILabel alloc] init];
        self.lrcLable.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
        self.lrcLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.lrcLable];
    }
    return self;
}
@end
