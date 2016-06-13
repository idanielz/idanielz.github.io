//
//  CategoryModel.h
//  MySinaNewsDemo
//
//  Created by qianfeng on 15/3/25.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray * subCategoryArray;
@end
