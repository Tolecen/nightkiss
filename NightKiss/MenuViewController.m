//
//  MenuViewController.m
//  TalkingPet
//
//  Created by wangxr on 14-7-7.
//  Copyright (c) 2014年 wangxr. All rights reserved.
//

#import "MenuViewController.h"
#import "RootViewController.h"
#import "SettingViewController.h"

@interface OtherCell : UITableViewCell
@property (nonatomic,retain)UIImageView * notiImageV;
@property (nonatomic,retain)UIImageView * xinFImageV;
@property (nonatomic,retain)UIImageView * iconView;
@property (nonatomic,retain)UILabel * titleL;
@end
@implementation OtherCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.iconView  = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth>320?10:5, 10, 25, 25)];
        _iconView.center = CGPointMake(_iconView.center.x, self.contentView.center.y);
        [self.contentView addSubview:_iconView];
        
        self.notiImageV = [[UIImageView alloc] initWithFrame:CGRectMake(50, 8, 10, 10)];
        [self.notiImageV setImage:[UIImage imageNamed:@"dotunread"]];
        [self.contentView addSubview:self.notiImageV];
        
        self.xinFImageV = [[UIImageView alloc] initWithFrame:CGRectMake(48, 8, 24, 10)];
        [self.xinFImageV setImage:[UIImage imageNamed:@"functionnew"]];
        [self.contentView addSubview:self.xinFImageV];
        
        self.titleL = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth>320?50:45, 0, 150, 20)];
        _titleL.center = CGPointMake(_titleL.center.x, _iconView.center.y);
        _titleL.textColor = [UIColor grayColor];
        _titleL.font = [UIFont boldSystemFontOfSize:15];
        _titleL.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_titleL];
        self.backgroundColor = [UIColor clearColor];
        for (UIView * view in self.subviews) {
            view.backgroundColor = [UIColor clearColor];
        }
    }
    return self;
}
@end
@interface MenuViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) NSArray * titleArr;
@property (nonatomic,retain) NSArray * iconArr;
@property (nonatomic,assign) BOOL needNotiChatMsg;
@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+22, 0,self.view.frame.size.width/2-22, self.view.frame.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor clearColor];
    self.titleArr = @[@"宠豆商城",@"M卡管理",@"会员礼包",@"互动吧",@"我的任务"];
    self.iconArr = @[@"market",@"free",@"bag",@"interactionBar",@"mytask_icon"];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)reloadView
{
    [_tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *otherCellIdentifier = @"cell";
    OtherCell *cell = [tableView dequeueReusableCellWithIdentifier:otherCellIdentifier ];
    if (cell == nil) {
        cell = [[OtherCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:otherCellIdentifier];
    }
    cell.titleL.text = _titleArr[indexPath.row];
    cell.iconView.image = [UIImage imageNamed:_iconArr[indexPath.row]];
    cell.notiImageV.hidden = YES;
    cell.xinFImageV.hidden = YES;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *navigationController = [RootViewController sharedRootViewController].mainNavi;
        SettingViewController * settingV = [[SettingViewController alloc] init];
        [navigationController pushViewController:settingV animated:YES];
        [[RootViewController sharedRootViewController].sideMenu hideMenuViewController];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
