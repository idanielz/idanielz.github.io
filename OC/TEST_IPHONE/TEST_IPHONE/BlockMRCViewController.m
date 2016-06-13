//
//  BlockMRCViewController.m
//  TEST_IPHONE
//
//  Created by 张继东 on 16/6/12.
//  Copyright © 2016年 idanielz. All rights reserved.
//

#import "BlockMRCViewController.h"
#import "Test.h"
@interface BlockMRCViewController ()

@end

@implementation BlockMRCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    Test  *test = [[Test alloc]init];
    __block int i = 0;
    test.b = ^(){
        if (i++ < 3) {
            NSLog(@"%d", i);
            //            [test ok];
        }
    };
    [test release];
    // Do any additional setup after loading the view.
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
