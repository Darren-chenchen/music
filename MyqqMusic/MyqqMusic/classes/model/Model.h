//
//  Model.h
//  MyqqMusic
//
//  Created by Darren on 15/11/27.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
@property(nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *image;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
