//
//  ArticleTableViewCell.h
//  NightKiss
//
//  Created by Tolecen on 15/6/30.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFHpple.h"
@protocol ArticleCellDelegate <NSObject>
@optional
-(void)resetCellHeightWithContentSizeH:(CGFloat)height;
-(void)articleClickedPicIndex:(int)index withArray:(NSArray *)array;
@end
@interface ArticleTableViewCell : UITableViewCell<UIWebViewDelegate>
{
    TFHpple *doc;
}
@property (nonatomic,strong)UIWebView * webview;
@property (nonatomic,assign)id <ArticleCellDelegate> delegate;
@property (nonatomic,strong)NSString * htmlStr;
@property (nonatomic,strong)NSData * htmlData;
@property (nonatomic,assign)BOOL loaded;
@property (nonatomic,strong)NSMutableArray * picArray;
@end
