//
//  RootViewController.m
//  AppleRssDemo
//
//  Created by leisure on 15/3/24.
//  Copyright (c) 2015年 leisure. All rights reserved.
//

#import "RootViewController.h"
#import "QFHttpManager.h"
@interface RootViewController ()

@end

@implementation RootViewController

-(void)dealloc
{
    [[QFHttpManager sharedManager] removeAllTask:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)addTask:(NSString *)url action:(SEL)action
{
    [[QFHttpManager sharedManager] addTask:url delegate:self action:action];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
