//
//  myCell.m
//  VistaSeeWorld
//
//  Created by qianfeng on 15-2-28.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "myCell.h"

@implementation myCell

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.imageView setFrame:CGRectMake(5, 5,60, 80)];
    //self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}
@end
