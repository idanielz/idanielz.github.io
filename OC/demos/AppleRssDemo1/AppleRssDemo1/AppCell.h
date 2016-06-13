//
//  AppCell.h
//  AppleRssDemo1
//
//  Created by qianfeng on 15/3/24.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *appImageView;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *summary;
@end
