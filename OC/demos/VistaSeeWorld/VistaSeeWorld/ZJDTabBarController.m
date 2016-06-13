//
//  ZJDTabBarController.m
//  VistaSeeWorld
//
//  Created by qianfeng on 15-2-28.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDTabBarController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
@interface ZJDTabBarController ()

@end

@implementation ZJDTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self createControllers];
}


- (void)createControllers
{
    FirstViewController *first = [[FirstViewController alloc]init];
    SecondViewController *second = [[SecondViewController alloc]init];
    UINavigationController *firstView = [[UINavigationController alloc]initWithRootViewController:first];
    UINavigationController *secondView = [[UINavigationController alloc]initWithRootViewController:second];

    firstView.tabBarItem = [[[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:0 ]autorelease];

    secondView.tabBarItem = [[[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemHistory tag:1 ]autorelease];
    NSArray *viewControllers = [NSArray arrayWithObjects:firstView,secondView, nil];
    [first release];
    [second release];
    [firstView release];
    [secondView release];
    self.viewControllers = viewControllers;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
