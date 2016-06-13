//
//  ZJDWebViewController.m
//  VistaSeeWorld
//
//  Created by qianfeng on 15-2-28.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDWebViewController.h"

@interface ZJDWebViewController ()

@end

@implementation ZJDWebViewController

-(void)dealloc
{
    self.url = nil;
    [super dealloc];
}
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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 640)];
    
    _url = [_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",_url);
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.url]];
    [webView loadRequest:request];
    [request release];
    [webView setUserInteractionEnabled:YES];
    webView.scalesPageToFit = YES;
    webView.scrollView.bounces = NO;

    [self.view addSubview:webView];
    [webView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"web release");
    [self.navigationController popViewControllerAnimated:YES];
    [self release];
}
@end
