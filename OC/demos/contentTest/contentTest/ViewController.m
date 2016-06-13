//
//  ViewController.m
//  contentTest
//
//  Created by 张继东 on 16/5/4.
//  Copyright © 2016年 idanielz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor blackColor];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height * 2)];
    view.backgroundColor = [UIColor orangeColor];
    [scrollView addSubview:view];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width , self.view.bounds.size.height *2);
    [self.view addSubview:scrollView];
    scrollView.contentInset = UIEdgeInsetsMake(100, 100, 100, 100);
    scrollView.contentOffset = CGPointMake(0, -100);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
