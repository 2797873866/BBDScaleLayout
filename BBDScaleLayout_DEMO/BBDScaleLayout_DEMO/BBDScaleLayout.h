
#import <UIKit/UIKit.h>

#define MinimumLineSpacing 10 // cell间距，实际间距肯定比这个大，最好设小一点
#define MaxScaleX 0.1 // 此数值乘以0.5，结果就是cellX轴缩放的最大比例
#define MaxScaleY 0.4 // 此数值乘以0.5，结果就是cellY轴缩放的最大比例

@interface BBDScaleLayout : UICollectionViewFlowLayout

// 因为无法实现滚动到指定indexPath的功能，提供简便方法一个
+ (void)collectionView:(UICollectionView *)collectionView ScrollToItem:(NSInteger)item;

@end
