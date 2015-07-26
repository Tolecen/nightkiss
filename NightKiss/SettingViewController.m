//
//  SettingViewController.m
//  NightKiss
//
//  Created by Tolecen on 15/6/30.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import "SettingViewController.h"
#import "UIImageView+WebCache.h"
#import "EGOCache.h"
#import "ProgressHUD.h"
#import "WebContentViewController.h"
@interface SettingViewController ()
{
    float cacheSize;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    cacheSize = .0f;
    self.view.backgroundColor = [UIColor clearColor];
    UIImageView * h = [[UIImageView alloc] initWithFrame:self.view.frame];
    h.image = [UIImage imageNamed:@"background"];
    [self.view addSubview:h];
    
    self.titleArray = [NSArray arrayWithObjects:@"设置",@"白府大院",@"关于我们",@"APP版本",@"和我说点什么",@"清除缓存", nil];
    
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
    
//    [self calCacheSizeOfSD];
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
    if (indexPath.row==0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
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
    
//    if (indexPath.row==1) {
//        UISwitch * switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(ScreenWidth-20-10-53, 10, 80, 30)];
//        [switchBtn setOn:YES];
//        [switchBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
//        [cell.contentView addSubview:switchBtn];
//    }
    if (indexPath.row==5){
        UILabel * subL = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-20-15-120, 0, 120, 50)];
        subL.backgroundColor = [UIColor clearColor];
        [subL setTextAlignment:NSTextAlignmentRight];
        [subL setTextColor:[UIColor colorWithWhite:180/255.0f alpha:1]];
        subL.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:subL];
        subL.text = [NSString stringWithFormat:@"%.2fM",cacheSize];
    }
    else if(indexPath.row!=5&&indexPath.row!=0)
    {
        UIImageView * morev = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-20-10-16, 14, 16, 22)];
        [morev setImage:[UIImage imageNamed:@"more_detail"]];
        [cell.contentView addSubview:morev];
    }

    return cell;

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self calCacheSize];
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
    if (indexPath.row==5) {
        [self clearCache];
    }
    else if (indexPath.row==1){
        WebContentViewController * wv = [[WebContentViewController alloc] init];
        wv.urlStr = @"http://mp.weixin.qq.com/s?__biz=MjM5MDk5Mjc0NA==&mid=208739886&idx=1&sn=45c962dbf0c9721de0a2527efe91360b&3rd=MzA3MDU4NTYzMw==&scene=6#rd";
        [self.navigationController pushViewController:wv animated:YES];
    }
    else if (indexPath.row==2){
        WebContentViewController * wv = [[WebContentViewController alloc] init];
        wv.urlStr = @"https://pingxx.com/recruit/";
        [self.navigationController pushViewController:wv animated:YES];
    }
}
-(void)calCacheSize
{
//    long long folderSize = 0;
    dispatch_queue_t queue = dispatch_queue_create("com.nightkiss.getCache", NULL);
    dispatch_async(queue, ^{
        NSFileManager* manager = [NSFileManager defaultManager];
        
        NSString* EGOCachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        EGOCachePath = [[[EGOCachePath stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]] stringByAppendingPathComponent:@"EGOCache"] copy];
        if ([manager fileExistsAtPath:EGOCachePath]){
            NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:EGOCachePath] objectEnumerator];
            NSString* fileName;
            while ((fileName = [childFilesEnumerator nextObject]) != nil){
                NSString* fileAbsolutePath = [EGOCachePath stringByAppendingPathComponent:fileName];
                cacheSize += ({
                    float addSize = 0;
                    if ([manager fileExistsAtPath:fileAbsolutePath]){
                        addSize = [[manager attributesOfItemAtPath:fileAbsolutePath error:nil] fileSize];
                    }
                    addSize;
                });
            }
        }
        [self calCacheSizeOfSD];
        [self calAudioSize];
        dispatch_async(dispatch_get_main_queue(), ^{
            cacheSize = cacheSize/(1024*1024);
            [self.settingTableV reloadData];
        });
    });
}
-(void)calCacheSizeOfSD
{
    cacheSize = cacheSize + [[SDImageCache sharedImageCache] getSize];
}
- (void)calAudioSize
{
//    __block NSUInteger size = 0;
    dispatch_queue_t queue = dispatch_queue_create("com.nightkiss.getAudioCache", NULL);
    dispatch_sync(queue, ^{
        NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:NSTemporaryDirectory()];
        for (NSString *fileName in fileEnumerator) {
            NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
            NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
            cacheSize += [attrs fileSize];
        }
    });
//    return size;
}
-(void)clearCache
{
    [ProgressHUD show:@"清理中..."];
    [self performSelector:@selector(realClean) withObject:nil afterDelay:.1];
}
-(void)realClean
{
    [[SDImageCache sharedImageCache] cleanDisk];
    [[EGOCache globalCache] clearCache];
    [self deleteAudioCache];
    [ProgressHUD showSuccess:@"清理完成"];
    cacheSize = .0f;
    [self.settingTableV reloadData];
}
-(void)deleteAudioCache
{
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:NSTemporaryDirectory()];
    for (NSString * fileName in fileEnumerator) {
        NSString * path = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
        [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
    }
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
