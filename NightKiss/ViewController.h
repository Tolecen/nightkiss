//
//  ViewController.h
//  NightKiss
//
//  Created by Tolecen on 15/6/30.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "JTSlideShadowAnimation.h"
#import "FSMaskControl.h"
//#import "MoreOperationView.h"
@interface ViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tableview;
@property (nonatomic,strong)UITableView * textTV;
@property (nonatomic,assign)CGFloat rowHeight;
@property (nonatomic,assign)int mediaType;
@property (nonatomic,assign)BOOL contentLoaded;
@property (nonatomic,strong)NSString * articleHTMLStr;
@property (strong, nonatomic) JTSlideShadowAnimation *shadowAnimation;
@property (strong, nonatomic) UIButton * moreBtn;
@property (strong, nonatomic) UIButton * backBtn;
@property (nonatomic, strong) FSMaskControl *maskControl;
@property (nonatomic,assign) BOOL isSecondaryPage;

@end

