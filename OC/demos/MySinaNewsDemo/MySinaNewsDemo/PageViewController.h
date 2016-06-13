//
//  PageViewController.h
//  MySinaNewsDemo
//
//  Created by qianfeng on 15/3/25.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "RootViewController.h"
#import "QFScrollView.h"
@interface PageViewController : RootViewController<QFScrollViewDelegate>

@property (nonatomic, assign)id delegate;
@property (nonatomic, assign)SEL action;
@end
