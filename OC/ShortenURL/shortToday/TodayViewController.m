//
//  TodayViewController.m
//  shortToday
//
//  Created by 张继东 on 16/6/6.
//  Copyright © 2016年 idanielz. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

#define BAIDUSHORTENURL @"http://dwz.cn/create.php"

@interface TodayViewController () <NCWidgetProviding>
@property (strong, nonatomic) IBOutlet UITextField *urlTextField;
@property (strong, nonatomic) IBOutlet UIButton *shortenBtn;
@property (strong, nonatomic) IBOutlet UIButton *cpBtn;
@property (strong, nonatomic) IBOutlet UIButton *ptBtn;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _urlTextField.clearButtonMode = UITextFieldViewModeAlways;

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    UIPasteboard *pastboard = [UIPasteboard generalPasteboard];
    _urlTextField.text = pastboard.string;
}
- (IBAction)shortenUrl:(id)sender {
    NSString *originStr = [_urlTextField text];
    [self shortenUrlWithBaidu:originStr];
    
}
- (IBAction)copyUrl:(id)sender {
    UIPasteboard *pastboard = [UIPasteboard generalPasteboard];
    pastboard.string = _urlTextField.text;
}
- (IBAction)pasteUrl:(id)sender {
    UIPasteboard *pastboard = [UIPasteboard generalPasteboard];
    _urlTextField.text = pastboard.string;
}


- (void)shortenUrlWithBaidu:(NSString *)originUrl
{
    if (originUrl.length > 0)
    {
        NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue currentQueue]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:BAIDUSHORTENURL]];
        [request setHTTPMethod:@"POST"];
        NSString *body = [NSString stringWithFormat:@"url=%@", originUrl];
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:nil];
                if ([dic isKindOfClass:[NSDictionary class]]) {
                    NSNumber *status = [dic valueForKey:@"status"];
                    if ([status intValue] == 0) {
                        NSString *tinyUrl = [dic valueForKey:@"tinyurl"];
                        NSLog(@"%@",tinyUrl);
                        _urlTextField.text = tinyUrl;
                    }
                }
            }
            
        }];
        [task resume];
    }
}

-(UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    //UIEdgeInsets newMarginInsets = UIEdgeInsetsMake(defaultMarginInsets.top, defaultMarginInsets.left - 16, defaultMarginInsets.bottom, defaultMarginInsets.right);
    //return newMarginInsets;
    //return UIEdgeInsetsZero; // 完全靠到了左边....
    return UIEdgeInsetsMake(0.0, 0, 0, 0);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
