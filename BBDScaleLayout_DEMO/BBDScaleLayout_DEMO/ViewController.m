//
//  ViewController.m
//  BBDScaleLayout_DEMO
//
//  Created by 李笑臣 on 2017/1/10.
//  Copyright © 2017年 李笑臣. All rights reserved.
//

#import "ViewController.h"
#import "BBDScaleLayout.h"
#import "CollectionViewCell.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray<NSString *> *imgNameArray;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imgNameArray = @[@"dianzixinxi", @"huaxuehuagong", @"jienenghuanbao", @"qita", @"shengwujishu", @"wenhuachuangyi", @"xianjinzhizao", @"xincailiao", @"xinengyuan"];
    
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:[CollectionViewCell ID]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 1. 创建自定义布局
    BBDScaleLayout *layout = [[BBDScaleLayout alloc] init];
    // 2. 设置UICollectionView中每个Item的size
    layout.itemSize = CGSizeMake(self.collectionView.bounds.size.width * 0.8, self.collectionView.bounds.size.height * 0.9);
    // 3. 指定layout
    self.collectionView.collectionViewLayout = layout;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imgNameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CollectionViewCell ID] forIndexPath:indexPath];
    
    cell.imgView.image = [UIImage imageNamed:self.imgNameArray[indexPath.item]];
    
    return cell;
}

// 因为自定义此流水布局中无法实现滚动到指定indexPath的功能，提供简便方法一个
- (void)collectionViewScrollToItem:(NSInteger)item
{
    BBDScaleLayout *layout = (BBDScaleLayout *)self.collectionView.collectionViewLayout;
    CGFloat offsetX = item * (layout.itemSize.width + MinimumLineSpacing);
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

// 测试使用
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self collectionViewScrollToItem:1];
}

@end
