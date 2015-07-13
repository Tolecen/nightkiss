//
//  MoreOperationView.m
//  NightKiss
//
//  Created by Tolecen on 15/7/4.
//  Copyright © 2015年 Tolecen. All rights reserved.
//

#import "MoreOperationView.h"
//#import "HMSideMenu.h"
@implementation MoreOperationView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction:)];
        [self addGestureRecognizer:tap];
        
        UIButton * awardBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [awardBtn setFrame:CGRectMake(0, 0, 40, 40)];
        awardBtn.tag = 1;
        [awardBtn setBackgroundImage:[UIImage imageNamed:@"bottom_btn_award@2x"] forState:UIControlStateNormal];
        [awardBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];

        
        UIButton * zanItem= [UIButton buttonWithType:UIButtonTypeCustom];
        [zanItem setFrame:CGRectMake(0, 0, 40, 40)];
        [zanItem setBackgroundImage:[UIImage imageNamed:@"bottom_btn_like@2x"] forState:UIControlStateNormal];
        zanItem.tag = 2;
        [zanItem addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * shareItem= [UIButton buttonWithType:UIButtonTypeCustom];
        [shareItem setFrame:CGRectMake(0, 0, 40, 40)];
        [shareItem setBackgroundImage:[UIImage imageNamed:@"bottom_btn_share@2x"] forState:UIControlStateNormal];
        shareItem.tag = 3;
        [shareItem addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        
    
       
        self.sideMenu = [[HMSideMenu alloc] initWithItems:@[awardBtn, zanItem, shareItem]];
        [self.sideMenu setItemSpacing:15.0f];
        self.sideMenu.menuPosition = HMSideMenuPositionBottom;
        //    self.sideMenu.animationDuration = 0.5;
        [self addSubview:self.sideMenu];

    }
    return self;
}
-(void)clicked:(UIButton *)button
{
    self.buttonClicked(button);
    [self closeAction:nil];
}
-(void)zanClicked:(UIImageView *)zanv
{
    
}

- (void)closeAction:(UIButton *)sender {
    self.dismissHandle(0);
}

@end
