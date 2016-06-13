//
//  MagazineDetailViewController.h
//  VistaSeeWorld
//
//  Created by qianfeng on 15-2-28.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MagazineDetailViewController : UIViewController <UINavigationControllerDelegate>

@property (copy) NSString *magid;
@property (copy) NSString *magDesc;
@property (copy) NSString *magTitle;
@property (copy) NSString *magTerm;
@property (copy) NSString *magTime;

@end
