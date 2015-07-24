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
- (instancetype)initWithFrame:(CGRect)frame type:(int)type {
    if (self = [super initWithFrame:frame]) {
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction:)];
        [self addGestureRecognizer:tap];
        
        if (type==0) {
            UIButton * awardBtn= [UIButton buttonWithType:UIButtonTypeCustom];
            [awardBtn setFrame:CGRectMake(0, 0, 42, 42)];
            awardBtn.tag = 1;
            [awardBtn setBackgroundImage:[UIImage imageNamed:@"bottom_shang"] forState:UIControlStateNormal];
            [awardBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
            
            
            UIButton * zanItem= [UIButton buttonWithType:UIButtonTypeCustom];
            [zanItem setFrame:CGRectMake(0, 0, 42, 42)];
            [zanItem setBackgroundImage:[UIImage imageNamed:@"bottom_like"] forState:UIControlStateNormal];
            zanItem.tag = 2;
            [zanItem addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton * colItem= [UIButton buttonWithType:UIButtonTypeCustom];
            [colItem setFrame:CGRectMake(0, 0, 42, 42)];
            [colItem setBackgroundImage:[UIImage imageNamed:@"bottom_collection"] forState:UIControlStateNormal];
            colItem.tag = 3;
            [colItem addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton * shareItem= [UIButton buttonWithType:UIButtonTypeCustom];
            [shareItem setFrame:CGRectMake(0, 0, 42, 42)];
            [shareItem setBackgroundImage:[UIImage imageNamed:@"bottom_share"] forState:UIControlStateNormal];
            shareItem.tag = 4;
            [shareItem addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            self.sideMenu = [[HMSideMenu alloc] initWithItems:@[awardBtn, zanItem,colItem, shareItem]];
            [self.sideMenu setItemSpacing:15.0f];
            self.sideMenu.menuPosition = HMSideMenuPositionBottom;
            //    self.sideMenu.animationDuration = 0.5;
            [self addSubview:self.sideMenu];
        }
        else
        {
            
        }
        

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
