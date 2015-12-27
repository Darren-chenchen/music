//
//  CustomCollectionViewCell.m
//  MyqqMusic
//
//  Created by Darren on 15/11/27.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
        [self.contentView addSubview:self.iconView];
        
        self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 100, 20)];
        self.nameLable.textAlignment = NSTextAlignmentCenter;
        self.nameLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.nameLable];
    }
    return self;
}

@end
