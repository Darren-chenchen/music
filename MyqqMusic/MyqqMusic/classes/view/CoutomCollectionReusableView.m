//
//  CoutomCollectionReusableView.m
//  MyqqMusic
//
//  Created by Darren on 15/11/27.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CoutomCollectionReusableView.h"

@implementation CoutomCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 30)];
        self.lable.font = [UIFont systemFontOfSize:16];
        self.lable.textAlignment = NSTextAlignmentLeft;
        self.lable.textColor = [UIColor redColor];
        [self addSubview:self.lable];
    }
    return self;
}


@end
