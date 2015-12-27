//
//  MineHeaderView.h
//  MyqqMusic
//
//  Created by Darren on 15/11/25.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineHeaderViewDelegate <NSObject>

@optional
- (void)devideButton:(UIButton *)btn;

@end

@interface MineHeaderView : UIView

@property(nonatomic,weak) id<MineHeaderViewDelegate> delegate;

@end
