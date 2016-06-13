//
//  OrientationImageViewController.m
//  test
//
//  Created by 张继东 on 16/6/2.
//  Copyright © 2016年 idanielz. All rights reserved.
//

#import "OrientationImageViewController.h"
#import "OrientationImageVIew.h"
@interface OrientationImageViewController ()

@end

@implementation OrientationImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    [self initSubviews];
}

- (void)initSubviews
{
    OrientationImageVIew * t = [[OrientationImageVIew alloc]initWithFrame:CGRectMake(30, 100, 200, 400)];
    t.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:t];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
