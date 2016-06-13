//
//  OrientationImageVIew.m
//  test
//
//  Created by 张继东 on 16/6/2.
//  Copyright © 2016年 idanielz. All rights reserved.
//

#import "OrientationImageVIew.h"

@implementation OrientationImageVIew

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)drawRect:(CGRect)rect
{
    CGFloat widthScale = 192 / self.bounds.size.width;
    CGFloat heightScale = 126 / self.bounds.size.width;
    CGFloat cornerWidth = widthScale * 34;
    CGFloat cornerHeight = heightScale * 25;
    CGRect upLeftCornerFrame = CGRectMake(0, 0, cornerWidth, cornerHeight);
    CGRect upRightCornerFrame = CGRectMake(self.bounds.size.width - cornerWidth, 0, cornerWidth, cornerHeight);
    CGRect downLeftCornerFrame = CGRectMake(0, self.bounds.size.height - cornerHeight, cornerWidth, cornerHeight);
    CGRect downRightCornerFrame = CGRectMake(self.bounds.size.width - cornerWidth, self.bounds.size.height - cornerHeight, cornerWidth, cornerHeight);

    UIImage *upLeftImage = [UIImage imageNamed:@"zan_corner_upleft_iphone"];
    UIImage *upRightImage = [UIImage imageWithCGImage:upLeftImage.CGImage scale:1.0 orientation:UIImageOrientationUpMirrored];      //垂直翻转, Y轴
    UIImage *downLeftImage = [UIImage imageWithCGImage:upLeftImage.CGImage scale:1.0 orientation:UIImageOrientationDownMirrored];   //水平翻转  X轴
    UIImage *downRightImage = [UIImage imageWithCGImage:upLeftImage.CGImage scale:1.0 orientation:UIImageOrientationDown];      //180度旋转
    [upLeftImage drawInRect:upLeftCornerFrame];
    [upRightImage drawInRect:upRightCornerFrame];
    [downLeftImage drawInRect:downLeftCornerFrame];
    [downRightImage drawInRect:downRightCornerFrame];
}
@end
