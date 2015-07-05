//
//  SettingViewController.h
//  NightKiss
//
//  Created by Tolecen on 15/6/30.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface SettingViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * settingTableV;
@property (nonatomic,strong) NSArray * titleArray;
@property (nonatomic,strong) UIButton * backBtn;
@end
