//
//  ViewController.h
//  2048Game
//
//  Created by qianfeng on 15-1-30.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myLabel.h"
@interface ViewController : UIViewController <UIGestureRecognizerDelegate , myLabelDelegate, UIAlertViewDelegate>

@property NSMutableArray * arrLabel;
@property UILabel *scoreLabel;
@property NSMutableArray *colorArray;
@end
