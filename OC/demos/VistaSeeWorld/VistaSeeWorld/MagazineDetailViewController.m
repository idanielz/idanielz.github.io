//
//  MagazineDetailViewController.m
//  VistaSeeWorld
//
//  Created by qianfeng on 15-2-28.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "MagazineDetailViewController.h"
#import "ZJDRequest.h"
#import "Header.h"
@interface MagazineDetailViewController ()
{
    NSMutableArray *itemsArray;
    NSMutableDictionary *itemsDict;
    ZJDRequest *request;
}
@end

@implementation MagazineDetailViewController

-(void)dealloc
{
    self.magid = nil;
    self.magTitle = nil;
    self.magDesc = nil;
    self.magTerm = nil;
    self.magTime = nil;
    [itemsArray release];
    [itemsDict release];
    [request release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        itemsDict = [[NSMutableDictionary alloc]init];
        itemsArray = [[NSMutableArray alloc]init];
        if (request == nil) {
            request = [[ZJDRequest alloc]init];
            request.block = ^(NSData *data){
                NSLog(@"下载3完毕");
                [self analyzeData:data];
                //NSLog(@"%@",magazinesArray);
            };
        }
       // NSLog(@"%@cccc", [NSString stringWithFormat:magazineDetailURL, self.magid]);
    }
    NSLog(@"init....");
    return self;
}

- (void)analyzeData: (NSData *)data
{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *items in dict[@"cats"]) {
        [itemsArray addObject: items[@"cat_name"]];
        [itemsDict setObject:items[@"list"] forKey:items[@"cat_name"]];
    }
    //[self.view re];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"4444444%@",_magTitle);
    [request requestURL:[NSString stringWithFormat:magazineDetailURL, _magid]];

    NSString *str = [NSString stringWithFormat:@"%@\n%@\n%@", _magTitle, _magTime, _magDesc];
    
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 65, 300, 150)];
    contentLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    contentLabel.numberOfLines = 0;
    contentLabel.adjustsFontSizeToFitWidth = YES;
    contentLabel.text = str;
    [self.view addSubview:contentLabel];
    [contentLabel release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"magazine release");
    [self release];
}

-(void)navigationBar:(UINavigationBar *)navigationBar shouldPopItem: (UINavigationItem *)item
{
    
}

@end
