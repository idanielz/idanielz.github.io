//
//  ViewController.m
//  TEST_IPHONE
//
//  Created by 张继东 on 16/6/12.
//  Copyright © 2016年 idanielz. All rights reserved.
//

#import "ViewController.h"
#import "BlockMRCViewController.h"
#import "OrientationImageViewController.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    self.dataSource = [[NSMutableArray alloc]init];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.tableView];
    [self createCells];

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)createCells
{
    [self addCellBlockMRC];
    [self addCellOrientationImage];
    [self.tableView reloadData];
}

#pragma mark - BlockMRC
- (void)addCellBlockMRC
{
    [self.dataSource addObject:@"BlockMRC"];
}
#pragma mark -

#pragma mark - OrientationImage
- (void)addCellOrientationImage
{
    [self.dataSource addObject:@"OrientationImage"];
}
#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [_dataSource objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            BlockMRCViewController *blockMRCVC = [[BlockMRCViewController alloc]init];
            [self.navigationController pushViewController:blockMRCVC animated:YES];
        }
            break;
        case 1:
        {
            OrientationImageViewController *orientationImageVC = [[OrientationImageViewController alloc]init];
            [self.navigationController pushViewController:orientationImageVC animated:YES];
        }
            break;
        default:
            break;
    }
}
@end
