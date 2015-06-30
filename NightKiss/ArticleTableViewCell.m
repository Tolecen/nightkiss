//
//  ArticleTableViewCell.m
//  NightKiss
//
//  Created by Tolecen on 15/6/30.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import "ArticleTableViewCell.h"

@implementation ArticleTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:234/255.0f alpha:1];
        self.contentView.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:234/255.0f alpha:1];
        
        self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-20, 100)];
        self.webview.backgroundColor = self.backgroundColor;
        self.webview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.webview.scalesPageToFit = NO;
        self.webview.delegate = self;
        [self.contentView addSubview:self.webview];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
        NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [self.webview loadHTMLString:html baseURL:nil];
        
    }
    return self;
}
- (void)webViewDidFinishLoad:(UIWebView *)myWebView
{
    self.webview.frame = CGRectMake(self.webview.frame.origin.x, self.webview.frame.origin.y, myWebView.frame.size.width, myWebView.scrollView.contentSize.height);
    if ([self.delegate respondsToSelector:@selector(resetCellHeightWithContentSizeH:)]) {
        [self.delegate resetCellHeightWithContentSizeH:myWebView.scrollView.contentSize.height];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
