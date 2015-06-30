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
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-20, 100)];
        self.webview.backgroundColor = self.backgroundColor;
//        self.webview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.webview.scalesPageToFit = YES;
        self.webview.delegate = self;
        self.webview.scrollView.scrollEnabled = NO;
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
    NSLog(@"webviewheight:%f,contentheight:%f",self.webview.frame.size.height,myWebView.scrollView.contentSize.height);
    if ([self.delegate respondsToSelector:@selector(resetCellHeightWithContentSizeH:)]) {
        [self.delegate resetCellHeightWithContentSizeH:myWebView.scrollView.contentSize.height];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
