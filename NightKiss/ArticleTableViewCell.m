//
//  ArticleTableViewCell.m
//  NightKiss
//
//  Created by Tolecen on 15/6/30.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import "ArticleTableViewCell.h"
//#import "TFHpple.h"
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
        
        self.picArray = [NSMutableArray array];
        
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.htmlStr&&!self.loaded&&![self.webview isLoading]) {
        [self startLoadContent];
    }
}
-(void)startLoadContent
{
   
    [self.webview loadHTMLString:self.htmlStr baseURL:nil];
}
-(BOOL)webView:(nonnull UIWebView *)webView shouldStartLoadWithRequest:(nonnull NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    NSLog(@"request:%@",request);
    if (self.loaded) {
        NSString * str = request.URL.absoluteString;
        BOOL havePic = NO;
        for (int i = 0; i<self.picArray.count; i++) {
            if ([str isEqualToString:self.picArray[i]]) {
//                j = i;
                havePic = YES;
                if ([self.delegate respondsToSelector:@selector(articleClickedPicIndex:withArray:)]) {
                    [self.delegate articleClickedPicIndex:i withArray:self.picArray];
                }
//                NSLog(@"catch%d",i);
            }
        }
        if (!havePic) {
            return YES;
        }
        else
            return NO;
    }
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)myWebView
{
    self.webview.frame = CGRectMake(self.webview.frame.origin.x, self.webview.frame.origin.y, myWebView.frame.size.width, myWebView.scrollView.contentSize.height);
//    NSLog(@"webviewheight:%f,contentheight:%f",self.webview.frame.size.height,myWebView.scrollView.contentSize.height);
    if ([self.delegate respondsToSelector:@selector(resetCellHeightWithContentSizeH:)]) {
        [self.delegate resetCellHeightWithContentSizeH:myWebView.scrollView.contentSize.height];
    }
    self.loaded = YES;
    NSData * data = [self.htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    doc = [TFHpple hppleWithHTMLData:data encoding:@"UTF-8"];
    NSArray * items = [doc searchWithXPathQuery:@"//img"];
//    NSLog(@"items:%@",items);
    for (TFHppleElement *item in items)
    {
        NSString * value = item.attributes[@"data-original"];
        if (!value||(value&&value.length<1)) {
            value = item.attributes[@"src"];
        }
//        NSString *
        [self.picArray addObject:value];
//        NSLog(@"attri:%@",value);
        
    }
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
