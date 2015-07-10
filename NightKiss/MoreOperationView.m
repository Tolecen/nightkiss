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
        
        UIView *twitterItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [twitterItem setMenuActionWithBlock:^{
            NSLog(@"tapped twitter item");
        }];
        UIImageView *twitterIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [twitterIcon setImage:[UIImage imageNamed:@"twitter"]];
        [twitterItem addSubview:twitterIcon];
        
        UIView *emailItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [emailItem setMenuActionWithBlock:^{
            NSLog(@"tapped email item");
        }];
        UIImageView *emailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30 , 30)];
        [emailIcon setImage:[UIImage imageNamed:@"email"]];
        [emailItem addSubview:emailIcon];
        
        UIView *facebookItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [facebookItem setMenuActionWithBlock:^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"Tapped facebook item"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Okay"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
            
        }];
        UIImageView *facebookIcon = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 35, 35)];
        [facebookIcon setImage:[UIImage imageNamed:@"facebook"]];
        [facebookItem addSubview:facebookIcon];
        
        UIView *browserItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [browserItem setMenuActionWithBlock:^{
            NSLog(@"tapped browser item");
        }];
        UIImageView *browserIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [browserIcon setImage:[UIImage imageNamed:@"browser"]];
        [browserItem addSubview:browserIcon];
        
        self.sideMenu = [[HMSideMenu alloc] initWithItems:@[twitterItem, emailItem, facebookItem, browserItem]];
        [self.sideMenu setItemSpacing:15.0f];
        self.sideMenu.menuPosition = HMSideMenuPositionBottom;
        //    self.sideMenu.animationDuration = 0.5;
        [self addSubview:self.sideMenu];

    }
    return self;
}

- (void)closeAction:(UIButton *)sender {
    self.dismissHandle(0);
}

@end
