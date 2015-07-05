//
//  SettingViewController.m
//  NightKiss
//
//  Created by Tolecen on 15/6/30.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    UIImageView * h = [[UIImageView alloc] initWithFrame:self.view.frame];
    h.image = [UIImage imageNamed:@"background"];
    [self.view addSubview:h];
    
    self.titleArray = [NSArray arrayWithObjects:@"设置",@"消息推送",@"关于我们",@"APP版本",@"意见反馈",@"清除缓存", nil];
    
    self.settingTableV = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth-20, ScreenHeight-20) style:UITableViewStylePlain];
    //    self.tableview.rowHeight = 200;
    self.settingTableV.delegate = self;
    self.settingTableV.dataSource = self;
    self.settingTableV.backgroundColor = [UIColor clearColor];
    self.settingTableV.layer.cornerRadius = 10;
    self.settingTableV.layer.masksToBounds = YES;
    self.settingTableV.backgroundView = nil;
    self.settingTableV.showsVerticalScrollIndicator = NO;
    self.settingTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.settingTableV];
//    self.settingTableV.scrollEnabled = NO;
    
    UIImageView * topv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-20, 30*(ScreenWidth-20)/732)];
    [topv setImage:[UIImage imageNamed:@"tvtop"]];
    self.settingTableV.tableHeaderView = topv;
    
    UIImageView * btv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-20, 30*(ScreenWidth-20)/732)];
    [btv setImage:[UIImage imageNamed:@"tvbottom"]];
    self.settingTableV.tableFooterView = btv;
    
    self.settingTableV.contentInset = UIEdgeInsetsMake(40, 0, 20, 0);
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setFrame:CGRectMake(20, ScreenHeight-20-10-42, 42, 42)];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"bottom_btn_back"] forState:UIControlStateNormal];
    [self.view addSubview:self.backBtn];
    [self.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *settingIdentifier = @"seetingcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:settingIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth-50, 50)];
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleLabel setTextAlignment:indexPath.row==0?NSTextAlignmentCenter:NSTextAlignmentLeft];
    [titleLabel setTextColor:[UIColor colorWithWhite:120/255.0f alpha:1]];
    titleLabel.font = indexPath.row==0?[UIFont boldSystemFontOfSize:16]:[UIFont systemFontOfSize:16];
    [cell.contentView addSubview:titleLabel];
    titleLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    
    if (indexPath.row==1) {
        UISwitch * switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(ScreenWidth-20-10-53, 10, 80, 30)];
        [switchBtn setOn:YES];
        [switchBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:switchBtn];
    }
    else if (indexPath.row==5){
        UILabel * subL = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-20-15-120, 0, 120, 50)];
        subL.backgroundColor = [UIColor clearColor];
        [subL setTextAlignment:NSTextAlignmentRight];
        [subL setTextColor:[UIColor colorWithWhite:180/255.0f alpha:1]];
        subL.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:subL];
        subL.text = @"3.0M";

    }
    else if(indexPath.row!=5&&indexPath.row!=0&&indexPath.row!=1)
    {
        UIImageView * morev = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-20-10-16, 14, 16, 22)];
        [morev setImage:[UIImage imageNamed:@"more_detail"]];
        [cell.contentView addSubview:morev];
    }

    return cell;

}
-(void)switchAction:(UISwitch *)sender
{
    BOOL isButtonOn = [sender isOn];
    if (isButtonOn) {
//        [sender setOn:NO];
    }
    else
    {
//        [sender setOn:YES];
    }
}
-(void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
