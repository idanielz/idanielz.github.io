//
//  FirstViewController.m
//  VistaSeeWorld
//
//  Created by qianfeng on 15-2-28.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "FirstViewController.h"
#import "ZJDRequest.h"
#import "Header.h"
#import "ZJDNews.h"
#import "myCell.h"
#import "ZJDWebViewController.h"
@interface FirstViewController ()
{
    NSMutableArray *newsArray;
    ZJDRequest *request;
    NSUInteger currentPage;
    ZJDWebViewController *wvc;
}
@end

@implementation FirstViewController

-(void)dealloc
{
    [newsArray release];
    [request release];
    [wvc release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        currentPage = 0;
        newsArray = [[NSMutableArray alloc]init];
        if (request == nil) {
            request = [[ZJDRequest alloc]init];
            request.block = ^(NSData *data){
                [self analyzeData:data];
                //NSLog(@"%@",newsArray);
            };
        }
        
    }
    return self;
}

- (void)analyzeData: (NSData *)data
{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *news in dict[@"list"]) {
        ZJDNews *new = [[ZJDNews alloc]init];
        [new setValuesForKeysWithDictionary:news];
        [newsArray addObject:new];
        [new release];
    }
    [self.tableView reloadData];
    NSLog(@" 1界面 解析 完毕");
}

- (void)toPrePage
{
    if (currentPage >= 10) {
        currentPage -= 10;
        [newsArray removeAllObjects];
        //NSLog(@"%@",[NSString stringWithFormat:@"%@%lu%@",newsPATH1, currentPage, newsPATH2]);
        [request requestURL:[NSString stringWithFormat:newsPATH, currentPage]];
        [self.tableView reloadData];
    }
}
- (void)toNextPage
{
    //if (currentPage >= 0) {
        currentPage += 10;
    [newsArray removeAllObjects];
    [request requestURL:[NSString stringWithFormat:newsPATH, currentPage]];
        [self.tableView reloadData];
    //}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"资讯";
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithTitle:@"上一页" style:UIBarButtonItemStylePlain target:self action:@selector(toPrePage)];
    
    self.navigationItem.leftBarButtonItem = left;
    [left release];
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"下一页" style:UIBarButtonItemStylePlain target:self action:@selector(toNextPage)];
    
    self.navigationItem.rightBarButtonItem = right;
    [right release];
    [request requestURL:[NSString stringWithFormat:newsPATH, currentPage]];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return newsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[[myCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myCell"] autorelease];
    }
    cell.textLabel.text = [newsArray[indexPath.row] title];
    cell.detailTextLabel.text = [newsArray[indexPath.row] desc];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:[newsArray[indexPath.row] icon]]]];
    if (image == nil) {
        cell.imageView.image = [UIImage imageNamed:@"blank.png"];
    }
    else{
        cell.imageView.image = image;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    wvc = [[ZJDWebViewController alloc]init];
    wvc.url = [NSString stringWithFormat:detailHTML, [newsArray[indexPath.row] id]];
    [self.navigationController pushViewController:wvc animated:YES];
    //[wvc release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
