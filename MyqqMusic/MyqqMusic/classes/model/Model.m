//
//  Model.m
//  MyqqMusic
//
//  Created by Darren on 15/11/27.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "Model.h"

@implementation Model

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.image = dict[@"image"];
    }
    return self;
}
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
