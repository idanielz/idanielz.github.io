//
//  AttributeStringViewController.m
//  TEST_IPHONE
//
//  Created by 张继东 on 16/6/16.
//  Copyright © 2016年 idanielz. All rights reserved.
//

#import "AttributeStringViewController.h"

@interface AttributeStringViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView * textView;
@end

@implementation AttributeStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _textView = [[UITextView alloc]initWithFrame:CGRectZero];
    _textView.font = [UIFont systemFontOfSize:12.0f];
    _textView.backgroundColor = [UIColor clearColor];
    [_textView setTintColor:[UIColor clearColor]];
    _textView.dataDetectorTypes =UIDataDetectorTypeLink;
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.contentMode = UIViewContentModeTop;
            _textView.selectable=NO;
    _textView.delegate = self;
    [_textView setEditable:NO];
    [_textView setScrollEnabled:NO];
    _textView.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5);
    //        _textView.contentMode = UIViewContentModeTop;
    _textView.frame = CGRectMake(0, 100, self.view.bounds.size.width - 50, 50);
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"您已为国旗点赞123109301392103901次, 获得抽奖机会, 点击抽奖"];
//    [str addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[NSURL URLWithString:@"lottery"], NSLinkAttributeName,[UIColor greenColor], NSForegroundColorAttributeName, nil] range:NSMakeRange(str.length - 4, 4)];
//    [str addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor], NSForegroundColorAttributeName, nil] range:NSMakeRange(0, str.length - 4)];
    
//    _textView.attributedText = str;
    _textView.text = @"xssafas";
    _textView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_textView];
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
