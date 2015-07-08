//
//  TextTableViewCell.h
//  NightKiss
//
//  Created by Tolecen on 15/7/8.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaCellDelegate.h"
@interface TextTableViewCell : UITableViewCell
@property (nonatomic,strong)UITextView * contentTextV;
@property (nonatomic,assign) id<MediaCellDelegate>delegate;
@property (nonatomic,strong)NSString * des;
@property (nonatomic,strong)NSAttributedString * attriStr;
@end
