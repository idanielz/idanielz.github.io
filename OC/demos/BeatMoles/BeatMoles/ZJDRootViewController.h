//
//  ZJDRootViewController.h
//  BeatMoles
//
//  Created by qianfeng on 15-3-10.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJDMole.h"

@interface ZJDRootViewController : UIViewController <ZJDMoleDelegate, UIAlertViewDelegate>


@property NSUInteger highestScore;
@end
