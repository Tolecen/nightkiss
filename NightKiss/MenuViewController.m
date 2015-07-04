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
        
        self.iconView  = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth/2-22-20-70)/2, 25, 70, 70)];
//        _iconView.center = CGPointMake(_iconView.center.x, self.contentView.center.y);
        self.iconView.backgroundColor = [UIColor grayColor];
        self.iconView.layer.cornerRadius = 35;
        self.iconView.layer.masksToBounds = YES;
        [self.contentView addSubview:_iconView];

        
        self.titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 95, ScreenWidth/2-22-20, 30)];
//        _titleL.center = CGPointMake(_titleL.center.x, _iconView.center.y);
        _titleL.textColor = [UIColor colorWithWhite:250/255.0f alpha:1];
        _titleL.font = [UIFont systemFontOfSize:14];
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_titleL];
        self.backgroundColor = [UIColor clearColor];
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

    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+22, (ScreenHeight-450)/2,self.view.frame.size.width/2-22-20, 450)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor clearColor];
    self.titleArr = @[@"往期晚安吻",@"我的收藏",@"设置"];
    self.iconArr = @[@"market",@"free",@"bag"];
    
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
    return 150;
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
