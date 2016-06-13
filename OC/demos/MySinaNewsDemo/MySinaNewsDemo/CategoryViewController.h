//
//  CategoryViewController.h
//  MySinaNewsDemo
//
//  Created by qianfeng on 15/3/25.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "RootViewController.h"
#import "QFScrollView.h"
#import "CategoryModel.h"
#import "Header.h"
@interface CategoryViewController : RootViewController<QFScrolViewDataDelegate>

@property (nonatomic, strong) CategoryModel * model;
@end
