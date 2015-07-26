//
//  MoreOperationView.h
//  NightKiss
//
//  Created by Tolecen on 15/7/4.
//  Copyright © 2015年 Tolecen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSideMenu.h"
@interface MoreOperationView : UIView
- (instancetype)initWithFrame:(CGRect)frame type:(int)type;
@property (nonatomic, copy) void(^dismissHandle)(NSInteger index);
@property (nonatomic, copy) void(^buttonClicked)(UIButton * button);
@property (nonatomic, strong) HMSideMenu *sideMenu;
@property (nonatomic, strong) HMSideMenu *secondSideMenu;
@end
