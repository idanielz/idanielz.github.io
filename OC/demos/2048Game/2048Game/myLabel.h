//
//  myLabel.h
//  2048Game
//
//  Created by qianfeng on 15-1-30.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol myLabelDelegate <NSObject>
    - (void)addNewNumber;
    - (void)setColorWithNumber;
@end

@interface myLabel : UILabel

@property (retain, nonatomic)NSString *number;
@property (retain, nonatomic)UIColor *color;
@property BOOL isShow;

@property id delegate;


- (void)changeColor;

@end
