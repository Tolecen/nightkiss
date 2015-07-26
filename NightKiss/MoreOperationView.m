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
            UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 62)];
            v1.backgroundColor  =[UIColor clearColor];
            [v1 addSubview:awardBtn];
            
            UILabel * l1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 42, 42, 20)];
            l1.backgroundColor = [UIColor clearColor];
            l1.textColor = [UIColor colorWithWhite:240/255.0f alpha:1];
            l1.textAlignment = NSTextAlignmentCenter;
            l1.font = [UIFont systemFontOfSize:12];
            l1.text = @"打赏";
            [v1 addSubview:l1];
            
            UIButton * zanItem= [UIButton buttonWithType:UIButtonTypeCustom];
            [zanItem setFrame:CGRectMake(0, 0, 42, 42)];
            [zanItem setBackgroundImage:[UIImage imageNamed:@"bottom_like"] forState:UIControlStateNormal];
            zanItem.tag = 2;
            [zanItem addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
            UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 62)];
            v2.backgroundColor  =[UIColor clearColor];
            [v2 addSubview:zanItem];
            
            UILabel * l2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 42, 42, 20)];
            l2.backgroundColor = [UIColor clearColor];
            l2.textColor = [UIColor colorWithWhite:240/255.0f alpha:1];
            l2.textAlignment = NSTextAlignmentCenter;
            l2.font = [UIFont systemFontOfSize:12];
            l2.text = @"喜欢";
            [v2 addSubview:l2];
            
            UIButton * colItem= [UIButton buttonWithType:UIButtonTypeCustom];
            [colItem setFrame:CGRectMake(0, 0, 42, 42)];
            [colItem setBackgroundImage:[UIImage imageNamed:@"bottom_collection"] forState:UIControlStateNormal];
            colItem.tag = 3;
            [colItem addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
            UIView *v3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 62)];
            v3.backgroundColor  =[UIColor clearColor];
            [v3 addSubview:colItem];
            
            UILabel * l3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 42, 42, 20)];
            l3.backgroundColor = [UIColor clearColor];
            l3.textColor = [UIColor colorWithWhite:240/255.0f alpha:1];
            l3.textAlignment = NSTextAlignmentCenter;
            l3.font = [UIFont systemFontOfSize:12];
            l3.text = @"收藏";
            [v3 addSubview:l3];
            
            UIButton * shareItem= [UIButton buttonWithType:UIButtonTypeCustom];
            [shareItem setFrame:CGRectMake(0, 0, 42, 42)];
            [shareItem setBackgroundImage:[UIImage imageNamed:@"bottom_share"] forState:UIControlStateNormal];
            shareItem.tag = 4;
            [shareItem addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
            
            UIView *v4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 62)];
            v4.backgroundColor  =[UIColor clearColor];
            [v4 addSubview:shareItem];
            
            UILabel * l4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 42, 42, 20)];
            l4.backgroundColor = [UIColor clearColor];
            l4.textColor = [UIColor colorWithWhite:240/255.0f alpha:1];
            l4.textAlignment = NSTextAlignmentCenter;
            l4.font = [UIFont systemFontOfSize:12];
            l4.text = @"分享";
            [v4 addSubview:l4];
            
            
            
            self.sideMenu = [[HMSideMenu alloc] initWithItems:@[v1, v2,v3, v4]];
            [self.sideMenu setItemSpacing:15.0f];
            self.sideMenu.menuPosition = HMSideMenuPositionRight;
            //    self.sideMenu.animationDuration = 0.5;
            [self addSubview:self.sideMenu];
            
//            [self.sideMenu open];
        }
        else
        {

        }
        

    }
    return self;
}
-(void)showShareView
{
    if (!self.secondSideMenu) {
        UIButton * awardBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [awardBtn setFrame:CGRectMake(0, 0, 42, 42)];
        awardBtn.tag = 100;
        [awardBtn setBackgroundImage:[UIImage imageNamed:@"weiChatFriend"] forState:UIControlStateNormal];
        [awardBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton * zanItem= [UIButton buttonWithType:UIButtonTypeCustom];
        [zanItem setFrame:CGRectMake(0, 0, 42, 42)];
        [zanItem setBackgroundImage:[UIImage imageNamed:@"friendCircle"] forState:UIControlStateNormal];
        zanItem.tag = 200;
        [zanItem addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * colItem= [UIButton buttonWithType:UIButtonTypeCustom];
        [colItem setFrame:CGRectMake(0, 0, 42, 42)];
        [colItem setBackgroundImage:[UIImage imageNamed:@"sina"] forState:UIControlStateNormal];
        colItem.tag = 300;
        [colItem addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * shareItem= [UIButton buttonWithType:UIButtonTypeCustom];
        [shareItem setFrame:CGRectMake(0, 0, 42, 42)];
        [shareItem setBackgroundImage:[UIImage imageNamed:@"qqicon"] forState:UIControlStateNormal];
        shareItem.tag = 400;
        [shareItem addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //    self.sideMenu = nil;
        
        self.secondSideMenu = [[HMSideMenu alloc] initWithItems:@[awardBtn, zanItem,colItem, shareItem]];
        [self.secondSideMenu setItemSpacing:15.0f];
        self.secondSideMenu.menuPosition = HMSideMenuPositionLeft;
        //    self.sideMenu.animationDuration = 0.5;
        [self addSubview:self.secondSideMenu];
        

    }
    [self.secondSideMenu layoutSubviews];
    [self.secondSideMenu open];
}
-(void)clicked:(UIButton *)button
{
    self.buttonClicked(button);
    if (button.tag!=4) {
//        MoreOperationView * gview = (MoreOperationView *)self.containerView;
        [self.sideMenu close];
        [self closeAction:nil];
    }
    if (button.tag==4) {
        [self.sideMenu close];
        [self showShareView];
    }
    
}
-(void)zanClicked:(UIImageView *)zanv
{
    
}

- (void)closeAction:(UIButton *)sender {
    if (self.secondSideMenu.isOpen) {
        [self.secondSideMenu close];
    }
    if (self.sideMenu.isOpen) {
        [self.sideMenu close];
    }
    self.dismissHandle(0);
}

@end
