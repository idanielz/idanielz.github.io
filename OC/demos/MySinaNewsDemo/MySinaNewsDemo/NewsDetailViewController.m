//
//  NewsDetailViewController.m
//  MySinaNewsDemo
//
//  Created by qianfeng on 15/3/26.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "CacheManager.h"
#import "QFHttpManager.h"
#import "QFHttpRequest.h"
@interface NewsDetailViewController ()
{
    UIWebView * _webView;
}
@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    CGRect frame  = [[UIScreen mainScreen]bounds];
    frame.size.height -= 65;
    _webView = [[UIWebView alloc]initWithFrame:frame];
    _webView.backgroundColor = [UIColor whiteColor];
    
//    NSData *data = [[CacheManager defaultManager]getDataFromUrl:self.url];
//    if (data) {
//        NSLog(@"%@已存在, 重新 加载网页",self.url);
////        NSLog(@"%@", data);
////        NSLog(@"%@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
//        [_webView loadHTMLString:[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] baseURL: nil];
//    }
//    else
//    {
//        NSLog(@"开始 加载网页");
//        [[QFHttpManager sharedManager]addTask:self.url delegate:self action:@selector(requestFinished:)];
//    }
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];

    [self.view addSubview:_webView];

}

-(void)requestFinished:(QFHttpRequest *)request
{
    NSData *data = [[NSString stringWithContentsOfURL:[NSURL URLWithString:self.url] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",data);
    [[CacheManager defaultManager]insertData: data withUrl:self.url];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
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
