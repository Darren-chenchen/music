//
//  MyAllMusic.m
//  MyqqMusic
//
//  Created by Darren on 15/11/26.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "MyAllMusic.h"

@implementation MyAllMusic

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)musicWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
