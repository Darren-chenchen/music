//
//  MyAllMusic.h
//  MyqqMusic
//
//  Created by Darren on 15/11/26.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAllMusic : NSObject

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *filename;
@property(nonatomic,copy) NSString *lrcname;
@property(nonatomic,copy) NSString *singer;
@property(nonatomic,copy) NSString *singerIcon;
@property(nonatomic,copy) NSString *icon;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)musicWithDict:(NSDictionary *)dict;

@end
