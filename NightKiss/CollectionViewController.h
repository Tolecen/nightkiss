//
//  CollectionViewController.h
//  NightKiss
//
//  Created by Tolecen on 15/7/5.
//  Copyright © 2015年 Tolecen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SecondViewController.h"
@interface CollectionViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    float lastOffsetY;
}
@property (nonatomic,strong) UICollectionView * contentView;
@property (nonatomic,strong) UIButton * backBtn;
@property (nonatomic,strong) UIImageView * bottomV;
@end
