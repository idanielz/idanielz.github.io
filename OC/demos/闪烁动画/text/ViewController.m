//
//  ViewController.m
//  text
//
//  Created by 张继东 on 16/4/19.
//  Copyright © 2016年 idanielz. All rights reserved.
//

#import "ViewController.h"
//#import <core>

@interface ViewController () <UITextFieldDelegate>
{
    UITextField *t;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    t = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, 200, 100)];
//    t.backgroundColor = [UIColor blueColor];
//    t.inputView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
////    UIView *acce = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
////    acce.backgroundColor = [UIColor blackColor];
////    t.inputAccessoryView = acce;
//    t.delegate = self;
//    [self.view addSubview: t];
//    [t becomeFirstResponder];
    
    
    UILabel * myTest1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 1, 40)];
    myTest1.backgroundColor = [UIColor blueColor];

    myTest1.textColor = [UIColor whiteColor];
    [self.view addSubview:myTest1];
    
    //闪烁效果。
        [myTest1.layer addAnimation:[self opacityForever_Animation:0.5] forKey:nil];
    ///移动的动画。
//        [myTest1.layer addAnimation:[self moveX:1.0f X:[NSNumber numberWithFloat:200.0f]] forKey:nil];
    //缩放效果。
//        [myTest1.layer addAnimation:[self scale:[NSNumber numberWithFloat:1.0f] orgin:[NSNumber numberWithFloat:3.0f] durTimes:2.0f Rep:MAXFLOAT] forKey:nil];
}


#pragma mark === 永久闪烁的动画 ======
-(CABasicAnimation *)opacityForever_Animation:(float)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    CGRect frame = t.inputView.frame;
//    t.frame = CGRectMake(0, self.view.frame.size.height - 100 -50, self.view.frame.size.width, 50);
//    return YES;
//}
@end
