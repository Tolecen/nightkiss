//
//  MediaCellDelegate.h
//  NightKiss
//
//  Created by Tolecen on 15/7/4.
//  Copyright © 2015年 Tolecen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MediaCellDelegate <NSObject>
-(void)moreBtnClicked:(id)sender;
-(void)backBtnClicked:(id)sender;
-(void)articleClickedPicIndex:(int)index withArray:(NSArray *)array;
-(void)resetCellHeightWithContentSizeH:(CGFloat)height;
-(void)toTextView;
@end
