//
//  ViewController.m
//  ShortenURL
//
//  Created by 张继东 on 16/6/6.
//  Copyright © 2016年 idanielz. All rights reserved.
//

#import "ViewController.h"
#define BAIDUSHORTENURL @"http://dwz.cn/create.php"
#define SHORTENACTION @"Shorten URL"
@interface ViewController ()<NSURLSessionDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *originUrlTF;
@property (strong, nonatomic) IBOutlet UIButton *tinyUrlBtn;
@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) IBOutlet UIImageView *arrowImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrowImageView.hidden = YES;
    UIPasteboard *pastboard = [UIPasteboard generalPasteboard];
    _originUrlTF.text = pastboard.string;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTouch:)];
    longPress.minimumPressDuration = 0.5;
    [_tinyUrlBtn addGestureRecognizer:longPress];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)longTouch:(UIGestureRecognizer *)longTouch
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"open in Safari" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *safariAction = [UIAlertAction actionWithTitle:@"open in Safari" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_tinyUrlBtn.titleLabel.text]];

    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionSheet addAction:safariAction];
    [actionSheet addAction:cancelAction];
    [self presentViewController:actionSheet animated:YES completion:nil];
}
- (IBAction)copyTinyUrl:(id)sender {
    if ([_tinyUrlBtn.titleLabel.text isEqualToString:SHORTENACTION]) {
        [self shortenUrlWithBaidu:_originUrlTF.text];
    }
    else
    {
        UIPasteboard *pastboard = [UIPasteboard generalPasteboard];
        pastboard.string = _originUrlTF.text;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"COPY Success" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:^{
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}
- (IBAction)touchDown:(id)sender {
    [_originUrlTF resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    _arrowImageView.hidden = YES;
    [_tinyUrlBtn setTitle:@"Shorten URL" forState:UIControlStateNormal];
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_originUrlTF resignFirstResponder];
    [self shortenUrlWithBaidu:textField.text];
    return YES;
}
- (void)shortenUrlWithBaidu:(NSString *)originUrl
{
    if (originUrl.length > 0)
    {
        NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue currentQueue]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:BAIDUSHORTENURL]];
        [request setHTTPMethod:@"POST"];
        NSString *body = [NSString stringWithFormat:@"url=%@", originUrl];
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        __weak typeof(self) weakSelf = self;

        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:nil];
                if ([dic isKindOfClass:[NSDictionary class]]) {
                    NSNumber *status = [dic valueForKey:@"status"];
                    if ([status intValue] == 0) {
                        NSString *tinyUrl = [dic valueForKey:@"tinyurl"];
                        NSLog(@"%@",tinyUrl);
                        [_tinyUrlBtn setTitle:tinyUrl forState:UIControlStateNormal];
                        _arrowImageView.hidden = NO;
                        [weakSelf dismissAlert];
                    }
                    else
                    {
                        [weakSelf showAlert:[NSString stringWithFormat:@"Failed\n%@",dic[@"err_msg"]] after:1];
                    }
                }
            }
            
        }];
        [task resume];
        [self showAlert:@"Wait" after:5];
    }
}

- (void)showAlert:(NSString *)alertContent after:(NSInteger)time
{
    __weak typeof(self) weakSelf = self;

    if (_alert) {
        [_alert dismissViewControllerAnimated:YES completion:^{
            _alert = [UIAlertController alertControllerWithTitle:alertContent message:nil preferredStyle:UIAlertControllerStyleAlert];
            [weakSelf presentViewController:_alert animated:YES completion:^{
                [weakSelf performSelector:@selector(dismissAlert) withObject:nil afterDelay:time];

            }];
        }];

    }
    if (!_alert) {
        _alert = [UIAlertController alertControllerWithTitle:alertContent message:nil preferredStyle:UIAlertControllerStyleAlert];
        [weakSelf presentViewController:_alert animated:YES completion:^{
            [weakSelf performSelector:@selector(dismissAlert) withObject:nil afterDelay:time];
            
        }];
    }
}

- (void)dismissAlert
{
    if (_alert) {
        [_alert dismissViewControllerAnimated:NO completion:^{
            _alert = nil;
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([_originUrlTF isFirstResponder]) {
        [_originUrlTF resignFirstResponder];
    }
    else{
        [_originUrlTF becomeFirstResponder];
    }
}
@end
