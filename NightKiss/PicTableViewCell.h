//
//  PicTableViewCell.h
//  NightKiss
//
//  Created by Tolecen on 15/7/1.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "PicInfo.h"
#import "MediaCellDelegate.h"
@interface PicTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel * timeL;
@property (nonatomic,strong) UIImageView * picImageview;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * artistL;
@property (nonatomic,strong) UILabel * desL;
@property (nonatomic,strong) UIButton * moreBtn;
@property (nonatomic,strong) PicInfo * picInfo;
@property (nonatomic,assign) id<MediaCellDelegate>delegate;
@end
