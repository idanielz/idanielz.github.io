//
//  PageViewController.m
//  MySinaNewsDemo
//
//  Created by qianfeng on 15/3/25.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "PageViewController.h"
#import "Header.h"
#import "NewsModel.h"
#import "QFHttpRequest.h"
#import "GDataXMLNode.h"
@interface PageViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView * _subTableView;
    NSMutableArray * _newsArray;
    NSInteger _currentPageIndex;
}
@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _newsArray = [[NSMutableArray alloc]init];
    CGRect frame = DEVICE_FRAME;
    frame.size.height -= 49 +64;
    _subTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    _subTableView.delegate = self;
    _subTableView.dataSource = self;
    [self.view addSubview:_subTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//清除旧数据
-(void)clearData
{
    [_newsArray removeAllObjects];
    [_subTableView reloadData];
}
//刷新指定页内容
-(void)updateData:(NSInteger)indexPage data:(id)dataObject
{
    if (_newsArray.count == 0) {
        [self addTask:dataObject action:@selector(requestFinished:)];
    }
}
//设置新页码
-(void)setPageIndex:(NSInteger)indexPage
{
    _currentPageIndex = indexPage;
}
//获得当前对象的页码
-(NSInteger)getPageIndex
{
    return _currentPageIndex;
}



- (void)requestFinished:(QFHttpRequest *)request
{
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:request.downloadData options:0 error:nil];
    if (doc) {
        NSArray * itemArray = [doc nodesForXPath:@"//item" error:nil];
        for (GDataXMLElement *element in itemArray) {
            NewsModel * model=[[NewsModel alloc] init];
            model.title=[element subElementValue:@"title"];
            model.summary=[element subElementValue:@"description"];
            model.urlLink = [element subElementValue:@"link"];
            [_newsArray addObject:model];
            
        }
//        NSLog(@"%@",_newsArray);
    }
    [_subTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _newsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"NewsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
    }
    cell.textLabel.text = [_newsArray[indexPath.row] title];
    cell.detailTextLabel.text = [_newsArray[indexPath.row] summary];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:self.action])
    {
        NewsModel *model = _newsArray[indexPath.row];
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        
        [self.delegate performSelector:self.action withObject:model.urlLink];
        #pragma clang diagnostic pop
    }
}
@end
