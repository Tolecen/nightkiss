//
//  ViewController.h
//  NightKiss
//
//  Created by Tolecen on 15/6/30.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tableview;
@property (nonatomic,assign)CGFloat rowHeight;
@property (nonatomic,assign)int mediaType;
@end
