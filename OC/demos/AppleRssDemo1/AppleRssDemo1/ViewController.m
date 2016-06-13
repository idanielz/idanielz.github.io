//
//  ViewController.m
//  AppleRssDemo1
//
//  Created by qianfeng on 15/3/24.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ViewController.h"
#import "ZJDHttpManager.h"
#import "ZJDHttpRequest.h"
#import "AppCell.h"
#import "AppModel.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()
{
    UITableView * _appTableView;
    NSMutableArray * _appArray;
}
@end

@implementation ViewController

-(void)dealloc
{
    [[ZJDHttpManager sharedManager]removeAllTask:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _appArray = [[NSMutableArray alloc]init];
    _appTableView = [[UITableView alloc]initWithFrame:[[UIScreen mainScreen]bounds] style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    [self.view addSubview:_appTableView];
    [[ZJDHttpManager sharedManager]addTask:@"https://itunes.apple.com/cn/rss/topfreeapplications/limit=50/genre=6004/json" delegate:self action:@selector(finishRequest:)];
    
    [_appTableView registerNib:[UINib nibWithNibName:@"AppCell" bundle:nil] forCellReuseIdentifier:@"AppCell"];
}

- (void)finishRequest:(ZJDHttpRequest *)request
{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:request.data options:NSJSONReadingMutableContainers error:nil];
    if (dict) {
        NSLog(@"%@",dict);
        NSArray *array = [[dict objectForKey:@"feed"]objectForKey:@"entry"];
        for (NSDictionary *dic in array) {
            AppModel *model = [[AppModel alloc]init];
            model.name = [[dic objectForKey:@"im:name"]objectForKey:@"label"];
            model.summary = [[dic objectForKey:@"summary"]objectForKey:@"label"];
            model.imageUrl = [[[dic objectForKey:@"im:image"] lastObject] objectForKey:@"label"];
            [_appArray addObject:model];
        }
    }
    [_appTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _appArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", indexPath.row);
    AppCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppCell" forIndexPath:indexPath];
    AppModel *model = [_appArray objectAtIndex:indexPath.row];
    cell.name.text = model.name;
    cell.summary.text = model.summary;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
@end
