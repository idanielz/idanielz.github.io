//
//  ZJDMole.h
//  BeatMoles
//
//  Created by qianfeng on 15-3-10.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZJDMoleDelegate <NSObject>

- (void)scoreChangeByBetean: (NSUInteger)score;

@end
@interface ZJDMole : UIImageView

@property BOOL isTop;
@property BOOL isBeaten;
@property BOOL isOut;
@property CGFloat moveSpeed;
@property NSUInteger score;
@property (nonatomic, assign) id<ZJDMoleDelegate> delegate;
- (void)resetMole;

- (void)setLevel;
- (void)move;
@end
