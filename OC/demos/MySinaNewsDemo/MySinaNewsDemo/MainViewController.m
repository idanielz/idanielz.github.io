//
//  MainViewController.m
//  MySinaNewsDemo
//
//  Created by qianfeng on 15/3/25.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "MainViewController.h"
#import "QFHttpManager.h"
#import "QFHttpRequest.h"
#import "GDataXMLNode.h"
#import "CategoryViewController.h"
#import "CategoryModel.h"
#import "SubCategoryModel.h"
@interface MainViewController ()
{
    NSMutableArray * _categoryArray;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _categoryArray  = [[NSMutableArray alloc]init];
    [[QFHttpManager sharedManager]addTask:@"http://rss.sina.com.cn/sina_all_opml.xml" delegate:self action:@selector(requestFinished:)];
    self.tabBar.tintColor = [UIColor redColor];

}

-(void)requestFinished:(QFHttpRequest *)request
{
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:request.downloadData options:0 error:nil];
    if (doc) {
        NSArray *outlineTitles = [doc nodesForXPath:@"/opml/body/outline" error:nil];
        for (GDataXMLElement *element in outlineTitles) {
            CategoryModel *model = [[CategoryModel alloc]init];
            NSMutableArray *subArray = [NSMutableArray array];
            NSString *title = [[element attributeValueByName:@"title"] stringByReplacingOccurrencesOfString:@"-新浪RSS" withString:@""];
            for (GDataXMLElement *subElement in [element children]) {
                SubCategoryModel *subModel = [[SubCategoryModel alloc]init];
                subModel.title = [subElement attributeValueByName:@"title"];
                subModel.xmlUrl = [subElement attributeValueByName:@"xmlUrl"];
                [subArray addObject:subModel];
            }
            model.title = title;
            model.subCategoryArray = subArray;
            [_categoryArray addObject:model];
        }
    }
    NSMutableArray * array = [NSMutableArray array];
    for (CategoryModel *model in _categoryArray) {
        CategoryViewController *cvc = [[CategoryViewController alloc]init];
        cvc.model = model;
        cvc.title = model.title;
        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:cvc];
        [array addObject:nc];
    }
    self.viewControllers = array;
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
