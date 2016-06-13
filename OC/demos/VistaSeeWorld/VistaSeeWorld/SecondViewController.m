//
//  SecondViewController.m
//  VistaSeeWorld
//
//  Created by qianfeng on 15-2-28.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "SecondViewController.h"
#import "ZJDRequest.h"
#import "Header.h"
#import "ZJDMagazine.h"
#import "myCell.h"
#import "MagazineDetailViewController.h"
@interface SecondViewController ()
{
    NSMutableArray *magazinesArray;
    ZJDRequest *request;
    NSUInteger currentPage;
    MagazineDetailViewController *mdc;
}
@end

@implementation SecondViewController

-(void)dealloc
{
    [magazinesArray release];
    [request release];
    [mdc release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        currentPage = 0;
        magazinesArray = [[NSMutableArray alloc]init];
        if (request == nil) {
            request = [[ZJDRequest alloc]init];
            request.block = ^(NSData *data){
                [self analyzeData:data];
                //NSLog(@"%@",magazinesArray);
            };
        }
        NSLog(@"%@bbbbb", [NSString stringWithFormat:magazineURL, currentPage]);
        
    }
    return self;
}

- (void)analyzeData: (NSData *)data
{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *magazines in dict[@"list"]) {
        ZJDMagazine *magazine = [[ZJDMagazine alloc]init];
        [magazine setValuesForKeysWithDictionary:magazines];
        [magazinesArray addObject:magazine];
        [magazine release];
    }
    
    [self.tableView reloadData];
    NSLog(@" 2界面 解析 完毕");

    
}

- (void)toPrePage
{
    if (currentPage >= 10) {
        currentPage -= 10;
        [magazinesArray removeAllObjects];
        [request requestURL:[NSString stringWithFormat:magazineURL, currentPage]];
        [self.tableView reloadData];
    }
}
- (void)toNextPage
{
    //if (currentPage >= 0) {
    currentPage += 10;
    [magazinesArray removeAllObjects];
    [request requestURL:[NSString stringWithFormat:magazineURL, currentPage]];
    [self.tableView reloadData];
    //}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"杂志";
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithTitle:@"上一页" style:UIBarButtonItemStylePlain target:self action:@selector(toPrePage)];
    
    self.navigationItem.leftBarButtonItem = left;
    [left release];
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"下一页" style:UIBarButtonItemStylePlain target:self action:@selector(toNextPage)];
    
    self.navigationItem.rightBarButtonItem = right;
    [right release];
    [request requestURL:[NSString stringWithFormat:magazineURL, currentPage]];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return magazinesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[[myCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myCell"] autorelease];
    }
    cell.textLabel.text = [magazinesArray[indexPath.row] title];
    cell.detailTextLabel.text = [magazinesArray[indexPath.row] desc];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:[magazinesArray[indexPath.row] cover]]]];
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
    mdc = [[MagazineDetailViewController alloc]init];
    NSLog(@"%@", [magazinesArray[indexPath.row] title]);
    mdc.magTitle = [magazinesArray[indexPath.row] title];
    mdc.magTime = [magazinesArray[indexPath.row] update_time];
    mdc.magDesc = [magazinesArray[indexPath.row] desc];
    mdc.magid = [magazinesArray[indexPath.row] id];
    mdc.magTerm = [magazinesArray[indexPath.row] vol_year];
    
    [self.navigationController pushViewController:mdc animated:YES];
    //[wvc release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
