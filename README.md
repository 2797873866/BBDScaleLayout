# BBDScaleCollectionLayout
将cell对齐屏幕中心，离中心越远的cell越小，比例可以自己控制

##动画演示
动画1MB左右，请耐心等待


![image](https://github.com/BBD2008/BBDScaleLayout/raw/master/gif.gif)

## 使用方式
1. 将DEMO中的BBDScaleLayout导入您的项目
2. 实例化BBDScaleLayout
3. 设置itemSize
4. 将layout指定给collectionView的collectionViewLayout属性

ps. cell间距，cell缩小比例等参数可在.h头文件的宏定义中修改

##提示
本布局无法使用scrollToItemAtIndexPath方法，DEMO中提供了替代方法：

`+ (void)collectionView:(UICollectionView *)collectionView ScrollToItem:(NSInteger)item`

