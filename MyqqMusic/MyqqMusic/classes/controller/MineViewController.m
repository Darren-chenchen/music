//
//  MineViewController.m
//  MyqqMusic
//
//  Created by Darren on 15/11/25.
//  Copyright © 2015年 darren. All rights reserved.
//
#define COLORWITHRGB [UIColor colorWithRed:78/255. green:38/255. blue:91/255. alpha:1]
#define BILI 0.15625
#define HEADBILI 0.4497

#import "MineViewController.h"
#import "MineHeaderView.h"
#import "MyAllMusicViewController.h"
#import "UIImage+MJ.h"
#import "MyMoverViewController.h"
#import "OtherViewController.h"
#import "MycollectionViewController.h"
#import "CeBianLanViewController.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,MineHeaderViewDelegate>

@property(nonatomic,weak) UIButton *mineBtn;
@property(nonatomic,weak) UIButton *musicBtn;
@property(nonatomic,weak) UIButton *discoverBtn;
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic,strong)CeBianLanViewController *cebianlanVC;

@end

@implementation MineViewController

- (CeBianLanViewController *)cebianlanVC
{
    if (_cebianlanVC == nil) {
        _cebianlanVC = [[CeBianLanViewController alloc] init];
    }
    return _cebianlanVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor =COLORWITHRGB;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // 设置导航栏上的内容
    [self setupNavgationController];
    
    // 添加scrllView
    [self addScrollView];
    
    // 刚加载就调用“我的”界面
    self.mineBtn.selected = YES;
}

/*创建scrollView*/
- (void)addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, 0);
    [self.view addSubview:scrollView];
    scrollView.pagingEnabled = YES;
    self.scrollView = scrollView;
    
    // 在scrollview 上加载3个tableView
    CGFloat tableViewW = self.view.frame.size.width;
    CGFloat tableViewH = self.view.frame.size.height;
    CGFloat tableViewY = 0;
    for (int i = 0; i < 3; i ++) {
        CGFloat tableViewX = i*self.view.frame.size.width;
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH) style:UITableViewStyleGrouped];

        tableView.tag = 100 + i;
        tableView.delegate = self;
        tableView.dataSource = self;
        [scrollView addSubview:tableView];
        self.tableView = tableView;
    }
}

/**设置导航栏上的内容*/
- (void)setupNavgationController
{
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clickSearch)];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*BILI, 50)];
    [btn2 setTitle:@"发现" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn2 addTarget:self action:@selector(clickDiscover:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn2 = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    self.discoverBtn = btn2;
    
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*BILI*2, 50)];
    [btn3 setTitle:@"音乐馆" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn3 addTarget:self action:@selector(clickMusicHouse:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn3 = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    self.musicBtn = btn3;
    
    UIButton *btn5 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*BILI, 50)];
    [btn5 setTitle:@"我的" forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn5 addTarget:self action:@selector(clickMine:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn5 = [[UIBarButtonItem alloc] initWithCustomView:btn5];
    self.mineBtn = btn5;
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [leftBtn setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [leftBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems= @[rightBtn,rightBtn2,rightBtn3,rightBtn5,leftButton];
    
}

- (void)clickLeftBtn
{
    [self.cebianlanVC show];
}

/**点击搜索按钮*/
- (void)clickSearch
{
    
}

/*点击”我的“按钮*/
- (void)clickMine:(UIButton *)mineBtn
{
    mineBtn.selected = YES;
    self.musicBtn.selected = NO;
    self.discoverBtn.selected = NO;
    [self.scrollView setContentOffset:CGPointMake(0,-64)];
}

/*点击音乐馆*/
- (void)clickMusicHouse:(UIButton *)musicBtn
{
    musicBtn.selected = YES;
    self.mineBtn.selected = NO;
    self.discoverBtn.selected = NO;
    [self.scrollView setContentOffset:CGPointMake(self.view.frame.size.width, -64)];
    
}

/*点击发现*/
- (void)clickDiscover:(UIButton *)discoverBtn
{
    discoverBtn.selected = YES;
    self.musicBtn.selected = NO;
    self.mineBtn.selected = NO;
    [self.scrollView setContentOffset:CGPointMake(2*self.view.frame.size.width, -64)];

}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 100) {
        return 2;
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 100 && section == 0) {
        return 1;
    } else if (tableView.tag == 100&&section == 1) {
        return 2;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        if (indexPath.section==1&&indexPath.row == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mine"];
            cell.textLabel.text = @"我的歌单";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        } else if (indexPath.section==0&&indexPath.row == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"mine2"];
            cell.textLabel.text = @"用户名";
            cell.detailTextLabel.text = @"今日听歌0分钟";
            cell.imageView.image = [UIImage circleImageWithName:@"qq" borderWidth:3 borderColor:[UIColor blueColor]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        } else if (indexPath.section == 1&&indexPath.row == 1){
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"mine3"];
            cell.textLabel.text = @"我最爱听";
            cell.detailTextLabel.text = @"43首";
            cell.imageView.image = [UIImage imageNamed:@"2"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
    
}

// 哪个组对应的头部控件的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 100) {
        if (section == 1) {
            return 300;
        } else{
            return 44;
        }
    }
    return 44;
        
}

// 头部控件
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 100) {
        if (section == 1) {
            MineHeaderView *head =[[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
            head.delegate = self;
            return head;
        }
    }
    return [[UIView alloc] init];
}

// 实现协议方法，点击了全部歌曲按钮，跳转到对应控制器
- (void)devideButton:(UIButton *)btn
{
    if (btn.tag == 100) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[MyAllMusicViewController alloc] init]];
        [self presentViewController:nav animated:YES completion:nil];
    } else if (btn.tag == 101){
        
        UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:[[MyMoverViewController alloc] init]];
        [self presentViewController:nav1 animated:YES completion:nil];
    } else{
        OtherViewController *other = [[OtherViewController alloc] init];
        [self presentViewController:other animated:YES completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[MyAllMusicViewController alloc] init]];
        [self presentViewController:nav animated:YES completion:nil];
    } else if (indexPath.section == 1 && indexPath.row == 1){
        MycollectionViewController *collection = [[MycollectionViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:collection];
        [self presentViewController:nav animated:YES completion:nil];
    }
}


@end
