//
//  ArticleTableViewCell.h
//  NightKiss
//
//  Created by Tolecen on 15/6/30.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ResetCellHeightDelegate <NSObject>
@optional
-(void)resetCellHeightWithContentSizeH:(CGFloat)height;
@end
@interface ArticleTableViewCell : UITableViewCell<UIWebViewDelegate>
@property (nonatomic,strong)UIWebView * webview;
@property (nonatomic,assign)id <ResetCellHeightDelegate> delegate;
@end
