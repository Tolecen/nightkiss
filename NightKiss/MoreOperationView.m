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
        [awardBtn setBackgroundImage:[UIImage imageNamed:@"bottom_btn_award@2x"] forState:UIControlStateNormal];
//        UIImageView *awardIcon = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 35, 35)];
//        [awardIcon setImage:[UIImage imageNamed:@"bottom_btn_award@2x"]];
//        [awardItem addSubview:awardIcon];
        
//        UIView *zanItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//        __block UIView * weakZan = zanItem;
//        [zanItem setMenuActionWithBlock:^{
//            NSLog(@"tapped email item");
//           
//        }];
//        UIImageView *zanIcon = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 35 , 35)];
//        zanIcon.tag = 1;
//        [zanIcon setImage:[UIImage imageNamed:@"bottom_btn_like@2x"]];
//        [zanItem addSubview:zanIcon];
        
        UIButton * zanItem= [UIButton buttonWithType:UIButtonTypeCustom];
        [zanItem setFrame:CGRectMake(0, 0, 40, 40)];
        [zanItem setBackgroundImage:[UIImage imageNamed:@"bottom_btn_like@2x"] forState:UIControlStateNormal];
        
        UIButton * shareItem= [UIButton buttonWithType:UIButtonTypeCustom];
        [shareItem setFrame:CGRectMake(0, 0, 40, 40)];
        [shareItem setBackgroundImage:[UIImage imageNamed:@"bottom_btn_share@2x"] forState:UIControlStateNormal];
        
//        UIView *shareItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//        [shareItem setMenuActionWithBlock:^{
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
//                                                                message:@"Tapped facebook item"
//                                                               delegate:nil
//                                                      cancelButtonTitle:@"Okay"
//                                                      otherButtonTitles:nil, nil];
//            [alertView show];
//            
//        }];
//        UIImageView *shareIcon = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 35, 35)];
//        [shareIcon setImage:[UIImage imageNamed:@"bottom_btn_share@2x"]];
//        [shareItem addSubview:shareIcon];
//        
       
        self.sideMenu = [[HMSideMenu alloc] initWithItems:@[awardBtn, zanItem, shareItem]];
        [self.sideMenu setItemSpacing:15.0f];
        self.sideMenu.menuPosition = HMSideMenuPositionBottom;
        //    self.sideMenu.animationDuration = 0.5;
        [self addSubview:self.sideMenu];

    }
    return self;
}

-(void)zanClicked:(UIImageView *)zanv
{
    
}

- (void)closeAction:(UIButton *)sender {
    self.dismissHandle(0);
}

@end
