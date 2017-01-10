//
//  MDScaleFlowLayout.m
//  maidian
//
//  Created by 李笑臣 on 2016/12/14.
//  Copyright © 2016年 zhongkechuangxiang. All rights reserved.
//

#import "MDScaleFlowLayout.h"

@implementation MDScaleFlowLayout

/**
 计算 targetContentOffset
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 获取当前layoutAttributes数组，获取每个cell的中心点坐标
    NSArray *layoutAttributesArray = [super layoutAttributesForElementsInRect:self.collectionView.bounds];
    // 根据当前contentOffset，计算当前中心点的x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    // 求当前中心点与当前需要显示的cell中心点的差值，即为偏移量差值
    CGFloat minOffset = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in layoutAttributesArray)
    {
        if(ABS(minOffset) > ABS(attr.center.x - centerX))
        {
            minOffset = attr.center.x - centerX;
        }
    }
    // 修改偏移量即为targetContentOffset
    proposedContentOffset.x += minOffset;
    return proposedContentOffset;
}

/**
 * 用来做布局的初始化操作（不建议在init方法中进行布局的初始化操作)
 */
- (void)prepareLayout {
    
    [super prepareLayout];
    
    // 水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置内边距
    CGFloat sectionInsetLeftAndRight = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, sectionInsetLeftAndRight, 0, sectionInsetLeftAndRight);
    self.minimumLineSpacing = MinimumLineSpacing;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 需要深拷贝一个新的数组,数组中保存着所有cell的大小和位置相关数据（此处如果不是深拷贝将会有系统警告出现！！！）
    NSArray *originAttrs = [super layoutAttributesForElementsInRect:rect];
    NSArray *attrs = [[NSArray alloc] initWithArray:originAttrs copyItems:YES];
    
    // 计算当前collectionView中心点x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    // 在原有的布局属性上进行微调达到缩放的效果
    for (UICollectionViewLayoutAttributes *attr in attrs)
    {
        // 计算cell中心点与当前屏幕中心点的差值,使用其控制cell缩放
        CGFloat dif = ABS(attr.center.x - centerX);
        if (dif > self.collectionView.frame.size.width * 0.5)
        {
            // 假如差值太大，肯定不能无止境的让cell缩小，差值最大值一般设置成屏幕的一半
            dif = self.collectionView.frame.size.width * 0.5;
        }
        // 距离屏幕中心越远，scale越接近0.5，距离屏幕中心跃进，scale越接近0
        CGFloat scale = dif / self.collectionView.frame.size.width;
        
        // 计算x轴的缩放比例，为了美观，x轴缩小不宜太大
        CGFloat scaleX = 1 - (scale * MaxScaleX);
        // 计算y轴的缩放比例
        CGFloat scaleY = 1 - (scale * MaxScaleY);
        // 核心代码，使用transform3D属性控制cell缩小
        attr.transform3D = CATransform3DMakeScale(scaleX, scaleY, 1);
    }
    return attrs;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
