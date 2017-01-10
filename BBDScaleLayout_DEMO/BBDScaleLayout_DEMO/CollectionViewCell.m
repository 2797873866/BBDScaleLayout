//
//  CollectionViewCell.m
//  BBDScaleLayout_DEMO
//
//  Created by 李笑臣 on 2017/1/10.
//  Copyright © 2017年 李笑臣. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell" owner:nil options:nil] lastObject];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.cornerRadius = 15;
    [self.layer masksToBounds];
}

+ (NSString *)ID
{
    return @"collectionViewCell";
}

@end
