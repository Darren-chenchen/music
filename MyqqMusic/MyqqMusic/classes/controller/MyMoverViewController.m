//
//  MyMoverViewController.m
//  MyqqMusic
//
//  Created by Darren on 15/11/26.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "MyMoverViewController.h"
#import "MovePlayerViewController.h"
#import "MyPlayerViewController.h"

@interface MyMoverViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) MyPlayerViewController *playController;


@end

@implementation MyMoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavgationController];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.rowHeight = 60;
}

- (void)setupNavgationController
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clickCancel)];
    
    // 创建UISegmentedControl
    NSArray *arr = @[@"已下载",@"正在下载"];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:arr];
    segment.frame = CGRectMake(0, 0,150, 40);
    segment.selectedSegmentIndex = 0;
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:segment];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    UIBarButtonItem *button2 = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    self.navigationItem.rightBarButtonItems = @[button2,btn];
}

- (void)clickCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell"; // 只分配一次内存空间
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text = @"漂亮的舞蹈";
    cell.imageView.image = [UIImage imageNamed:@"main_04"];
    cell.detailTextLabel.text = @"哈哈哈哈哈哈哈";
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//点击cell没有阴影显示
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[MovePlayerViewController alloc] init]];
    
    [self.playController.avPlayer pause];

    [self presentViewController:nav animated:YES completion:nil];
}


@end
