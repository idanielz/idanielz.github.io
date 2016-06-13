//
//  CategoryViewController.m
//  MySinaNewsDemo
//
//  Created by qianfeng on 15/3/25.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "CategoryViewController.h"
#import "PageViewController.h"
#import "SubCategoryModel.h"
#import "NewsDetailViewController.h"
@interface CategoryViewController () <UIScrollViewDelegate>
{
    QFScrollView * _reuseScrollView;
    UIScrollView * _titleScrollView;
}
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    _reuseScrollView = [[QFScrollView alloc]initWithFrame:DEVICE_FRAME count:self.model.subCategoryArray.count];
    _reuseScrollView.delegateEx = self;
    _reuseScrollView.pagingEnabled = YES;
    _reuseScrollView.contentSize = CGSizeMake(self.model.subCategoryArray.count *DEVICE_FRAME.size.width, DEVICE_FRAME.size.height-49 - 64);
    _reuseScrollView.directionalLockEnabled = YES;
    [_reuseScrollView tilePages];
    [self.view addSubview:_reuseScrollView];
    [self createTitleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createTitleView
{
    _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(20, 0, DEVICE_FRAME.size.width - 80, 30)];
    for (NSInteger i = 0; i < self.model.subCategoryArray.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(i * 80, 0, 80, 30);
        [button setTitle:[[self.model.subCategoryArray objectAtIndex:i] title] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        button.tag = 100 + i;
        if (i == 0) {
            button.selected = YES;
        }
        [button addTarget: self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_titleScrollView addSubview:button];
    }
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    _titleScrollView.contentSize = CGSizeMake(self.model.subCategoryArray.count * 80, 30);
    self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
    self.navigationItem.titleView = _titleScrollView;
}

- (void)buttonClick:(UIButton *)button
{
    [_reuseScrollView changePage:(int)button.tag - 100 animated:YES];
    [self pageChange:button.tag - 100 animated:YES];
}
//返回总页码
-(NSInteger)numberOfPages
{
    return self.model.subCategoryArray.count;
}
//获得指定页的位置和大小
-(CGSize)perPageSize
{
    CGRect frame = DEVICE_FRAME;
    frame.size.height -= 49 + 64;
    return frame.size;
}
//获得指定页实例
-(id<QFScrollViewDelegate>)pageForIndex:(NSInteger)index
{
    PageViewController * pvc = [[PageViewController alloc]init];
    pvc.delegate = self;
    pvc.action = @selector(onClick:);
    return pvc;
}

- (void)onClick:(NSString *)url
{
    NewsDetailViewController *newDetail = [[NewsDetailViewController alloc]init];
    newDetail.url = url;
    [self.navigationController pushViewController:newDetail animated:YES];
}
//返回要显示的数据对象
-(id)dataObjectForIndex:(NSInteger)index
{
    return [[self.model.subCategoryArray objectAtIndex:index] xmlUrl];
}


//跳转到指定页
-(void)pageChange:(NSInteger)pageNumber animated:(BOOL)animated
{
    CGFloat currentOffset = pageNumber/3 * (DEVICE_FRAME.size.width - 80);
    NSLog(@"xxxx%lf", currentOffset);
    _titleScrollView.contentOffset = CGPointMake(currentOffset, 0);
    for (NSInteger i = 0; i < self.model.subCategoryArray.count; i++) {
        UIButton *btn =  (id)[self.navigationItem.titleView viewWithTag:i+100];
        if (i != pageNumber) {
            btn.selected = NO;
        }
        else
            btn.selected = YES;
    }
}



@end
