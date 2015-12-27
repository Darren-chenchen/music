//
//  MycollectionViewController.m
//  MyqqMusic
//
//  Created by Darren on 15/11/27.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "MycollectionViewController.h"
#import "Model.h"
#import "CustomCollectionViewCell.h"
#import "CoutomCollectionReusableView.h"

@interface MycollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSArray *Arr;

@end

@implementation MycollectionViewController

static NSString *ID = @"cell";  // cell的标识
static NSString *headID = @"head"; // 头部控件的标识
static NSString *footID = @"foot";  // 尾部控件的标示


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clickCancel)];
    // 创建UICollectionView
    // 1.UICollectionView是一个抽象类，不具备创建对象的能力
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    
    // 视图滚动的方向默认是竖直的
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    // 最小行间距
    flowlayout.minimumLineSpacing = 10;
    // 最小列间距
    flowlayout.minimumInteritemSpacing = 20;
    
    // item的大小
    flowlayout.itemSize = CGSizeMake(100, 100);
    
    // 设置4周距离
    flowlayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    // 头部的尺寸
    flowlayout.headerReferenceSize = CGSizeMake(0, 20);
    flowlayout.footerReferenceSize = CGSizeMake(0, 20);
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowlayout];
    collection.delegate = self;
    collection.dataSource = self;
    collection.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collection];
    
    // 注册UICollectionViewCell
    [collection registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    // 注册头部控件
    [collection registerClass:[CoutomCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headID];
    // 注册尾部空间
    [collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footID];
}

/*懒加载*/
- (NSArray *)Arr
{
    if (_Arr == nil) {
        
        NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"singer.plist" ofType:nil]];
        
        NSMutableArray *mutArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            
            Model *model = [Model modelWithDict:dict];
            [mutArr addObject:model];
        }
        _Arr = mutArr;
        
    }
    return _Arr;
}

- (void)clickCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 数据源方法
// 多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}

// 每组有多少个控件
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

// 创建cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    Model *model = self.Arr[indexPath.row];
    
    cell.nameLable.text = model.name;
    cell.iconView.image =[UIImage imageNamed:model.image];
    return cell;
}

// 创建头部控件及尾部控件
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        CoutomCollectionReusableView *reusable = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headID forIndexPath:indexPath];
        if (indexPath.section == 0) {
            reusable.lable.text = @"大陆女歌手";
        } else if (indexPath.section==1){
            reusable.lable.text = @"华语男歌手";
        }else if (indexPath.section==2){
            reusable.lable.text = @"华语女歌手";
        }else if (indexPath.section==3){
            reusable.lable.text = @"大陆男歌手";
        }else{
            reusable.lable.text = @"港台";
        }
        return reusable;
    }else {
        UICollectionReusableView *reusable = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footID forIndexPath:indexPath];
        return reusable;
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
