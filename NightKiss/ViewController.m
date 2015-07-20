//
//  ViewController.m
//  NightKiss
//
//  Created by Tolecen on 15/6/30.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import "ViewController.h"
#import "ArticleTableViewCell.h"
#import "MusicTableViewCell.h"
#import "PicTableViewCell.h"
#import "TextTableViewCell.h"
#import "Track.h"
#import "TFHpple.h"
#import "UIImageView+WebCache.h"
#import "ACImageBrowser.h"
#import "MediaCellDelegate.h"
#import "MoreOperationView.h"
#import "PicInfo.h"
#import "XLFlipView.h"
@interface ViewController ()<ACImageBrowserDelegate,MediaCellDelegate>
{
    float lastOffsetY;
}
@property (nonatomic,strong)Track * currentTrack;
@property (nonatomic,strong)PicInfo * currentPicInfo;
@property (nonatomic,strong)MoreOperationView * moreView;
@property (nonatomic,strong)XLFlipView * cms;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mediaType = 0;
//    NSString * s = [[NSUserDefaults standardUserDefaults] objectForKey:@"mediaType"];
//    if (s) {
//        if ([s intValue]==0) {
//            self.mediaType = 1;
//        }
//        else if([s intValue]==1){
//            self.mediaType = 2;
//        }
//        else if ([s intValue]==2){
//            self.mediaType = 0;
//        }
//    }
// 
//    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",self.mediaType] forKey:@"mediaType"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (self.isSecondaryPage) {
        self.mediaType = arc4random()%3;
    }
    self.rowHeight = NormalCellHeight;
    
    UILabel * loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (ScreenHeight-30)/2, ScreenWidth, 30)];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.text = @"NightKiss is on road...";
    [self.view addSubview:loadingLabel];
    
    self.shadowAnimation = [JTSlideShadowAnimation new];
    self.shadowAnimation.shadowForegroundColor = [UIColor colorWithRed:255/255.0f green:97/255.0f blue:0 alpha:0.3];
    self.shadowAnimation.shadowBackgroundColor = [UIColor whiteColor];
    self.shadowAnimation.animatedView = loadingLabel;
    self.shadowAnimation.shadowWidth = 80.;
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(10, 20, ScreenWidth-20, ScreenHeight-20) style:UITableViewStylePlain];
//    self.tableview.rowHeight = 200;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    self.tableview.backgroundView = nil;
    self.tableview.showsVerticalScrollIndicator = NO;
//    [self.view addSubview:self.tableview];
    
    self.textTV = [[UITableView alloc] initWithFrame:CGRectMake(10, 20, ScreenWidth-20, ScreenHeight-20) style:UITableViewStylePlain];
    //    self.tableview.rowHeight = 200;
    self.textTV.delegate = self;
    self.textTV.dataSource = self;
    self.textTV.backgroundColor = [UIColor clearColor];
    self.textTV.backgroundView = nil;
    self.textTV.showsVerticalScrollIndicator = NO;
//    [self.view addSubview:self.textTV];
    
    self.cms = [[XLFlipView alloc] initWithPrimaryView:self.tableview andSecondaryView:self.textTV inFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight)];
    [self.view addSubview:self.cms];
    
    UIImageView * topv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-20, 30*(ScreenWidth-20)/732)];
    [topv setImage:[UIImage imageNamed:@"tvtop"]];
    self.tableview.tableHeaderView = topv;
    
    UIImageView * topv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-20, 30*(ScreenWidth-20)/732)];
    [topv2 setImage:[UIImage imageNamed:@"tvtop"]];
    self.textTV.tableHeaderView = topv2;
    
    UIImageView * btv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-20, 30*(ScreenWidth-20)/732)];
    [btv setImage:[UIImage imageNamed:@"tvbottom"]];
    self.tableview.tableFooterView = btv;
    
    UIImageView * btv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-20, 30*(ScreenWidth-20)/732)];
    [btv2 setImage:[UIImage imageNamed:@"tvbottom"]];
    self.textTV.tableFooterView = btv2;
    
    self.tableview.contentInset = UIEdgeInsetsMake(20, 0, 20, 0);
    self.textTV.contentInset = UIEdgeInsetsMake(20, 0, 20, 0);
    
    
    
    
    [self.shadowAnimation start];
    
    _moreView = [[MoreOperationView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    __weak __typeof(self) wSelf = self;
    [_moreView setDismissHandle:^(NSInteger index) {
        NSLog(@"theIndex:%ld",(long)index);
        [wSelf.maskControl dismissIndex:index];
    }];
    [_moreView setButtonClicked:^(UIButton * button) {
        NSLog(@"button.tag:%d",button.tag);
        [wSelf moreOperationButtonClicked:button];
    }];
    
    
    
    [self loadedContent];
    //暂时延时调用，应该是内容加载完成之后调用，之前给个动画加载中...
    if (!self.isSecondaryPage) {
        [self performSelector:@selector(appearTheTable) withObject:nil afterDelay:3];
        //    [self getTodayContent];
        
        
 

    }
    else
    {
        [self.cms setFrame:self.view.frame];
        if (self.mediaType==0) {
            if (!self.moreBtn) {
                self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [self.moreBtn setFrame:CGRectMake(ScreenWidth-20-42, ScreenHeight-20-10-42, 42, 42)];
                [self.moreBtn setBackgroundImage:[UIImage imageNamed:@"bottom_btn_more"] forState:UIControlStateNormal];
                [self.view addSubview:self.moreBtn];
                self.moreBtn.tag = 1;
                [self.moreBtn addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            }
            if (!self.backBtn) {
                self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [self.backBtn setFrame:CGRectMake(20, ScreenHeight-20-10-42, 42, 42)];
                [self.backBtn setBackgroundImage:[UIImage imageNamed:@"bottom_btn_back"] forState:UIControlStateNormal];
                [self.view addSubview:self.backBtn];
                self.backBtn.tag = 9;
                [self.backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }

    // Do any additional setup after loading the view, typically from a nib.
}
-(void)moreOperationButtonClicked:(UIButton *)button
{
    
}
-(void)getTodayContent
{
    [NetManager requestWithReqPath:@"/nightkiss/getAllMedias" Parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (self.mediaType==0) {
            NSDictionary * dict = [responseObject objectForKey:@"medias"][1];
            self.articleHTMLStr = [dict objectForKey:@"raw_text"];
            [self.tableview reloadData];
        }
        else{
            if (!self.currentTrack) {
                self.currentTrack = [[Track alloc] init];
                [self.currentTrack setArtist:@"久石譲"];
                [self.currentTrack setTitle:@"Summer"];
                self.currentTrack.albumUrlStr = @"http://7d9jfr.com1.z0.glb.clouddn.com/jiu82233.png?imageView2/2/w/500";
                //            [self.currentTrack setAudioFileURL:[NSURL URLWithString:@"http://7d9jfr.com1.z0.glb.clouddn.com/qianqianquege.mp3"]];
                
                [self.currentTrack setAudioFileURL:[NSURL URLWithString:@"http://7d9jfr.com1.z0.glb.clouddn.com/summerjiushir.mp3"]];
                
                [self.tableview reloadData];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(void)dismissAtIndex:(NSInteger)index
{
    
}

-(void)loadedContent
{
    if (self.mediaType==0) {
        //        self.contentLoaded = YES;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
        self.articleHTMLStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [self.tableview reloadData];
    }
    else if (self.mediaType==1){
        if (!self.currentTrack) {
            self.currentTrack = [[Track alloc] init];
            [self.currentTrack setArtist:@"久石譲"];
            [self.currentTrack setTitle:@"Summer"];
            self.currentTrack.albumUrlStr = @"http://7d9jfr.com1.z0.glb.clouddn.com/jiu82233.png?imageView2/2/w/500";
            //            [self.currentTrack setAudioFileURL:[NSURL URLWithString:@"http://7d9jfr.com1.z0.glb.clouddn.com/qianqianquege.mp3"]];
            
            [self.currentTrack setAudioFileURL:[NSURL URLWithString:@"http://7d9jfr.com1.z0.glb.clouddn.com/summerjiushir.mp3"]];
            
            self.currentTrack.des = @"  就卡死角度看拉克的拉伸看到了撒旦老师；克拉；斯柯达拉SD卡卡上的撒娇打开撒娇的卡上的骄傲的骄傲SD卡就卡手机德库拉圣诞节奥斯卡的\n  爱打架阿斯利康多久啊是肯定卡手机的撒旦可拉伸的卷卡式带就撒旦就撒肯德基阿斯顿啊了的控件阿斯利康的骄傲的就仨肯德基奥斯卡的骄傲是看得见啊三等奖哦i";
            [self.tableview reloadData];
        }
    }
    else if (self.mediaType==2){
        self.currentPicInfo = [[PicInfo alloc] init];
        self.currentPicInfo.imageUrl = @"http://i1.topit.me/1/09/15/1197700626e3c15091l.jpg";
        self.currentPicInfo.ratioWH = 1.5;
        self.currentPicInfo.title = @"不吃猫的老鼠jjssjsj接啊加大是件大事肯德基奥斯卡的进口量撒娇打算";
        self.currentPicInfo.artist = @"小黄鸡";
        self.currentPicInfo.des = @"  就卡死角度看拉克的拉伸看到了撒旦老师；克拉；斯柯达拉SD卡卡上的撒娇打开撒娇的卡上的骄傲的骄傲SD卡就卡手机德库拉圣诞节奥斯卡的\n  爱打架阿斯利康多久啊是肯定卡手机的撒旦可拉伸的卷卡式带就撒旦就撒肯德基阿斯顿啊了的控件阿斯利康的骄傲的就仨肯德基奥斯卡的骄傲是看得见啊三等奖哦i";
        [self.tableview reloadData];
    }
    
    NSLog(@"dd%f,%f,%f",self.view.frame.size.width,ScreenWidth,ScreenHeight);
    

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

// After the content loaded, use this method.
-(void)appearTheTable
{
    [self.shadowAnimation stop];
    [UIView animateWithDuration:0.6
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.cms setFrame:self.view.frame];
                     } completion:^(BOOL finished) {
                         if (self.mediaType==0) {
                             if (!self.moreBtn) {
                                 self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                                 [self.moreBtn setFrame:CGRectMake(ScreenWidth-20-42, ScreenHeight-20-10-42, 42, 42)];
                                 [self.moreBtn setBackgroundImage:[UIImage imageNamed:@"bottom_btn_more"] forState:UIControlStateNormal];
                                 [self.view addSubview:self.moreBtn];
                                 self.moreBtn.tag = 1;
                                 [self.moreBtn addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                             }
                         }
                     }];
}

-(void)setAudioStreamer
{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.mediaType==0&&![tableView isEqual:self.tableview]) {
        return 0;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableview]) {
        if (self.mediaType==0) {
            return self.rowHeight;
        }
        else
            return NormalCellHeight;
    }
    else
        return NormalCellHeight;

    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableview]) {
        if (self.mediaType==0) {
            static NSString *otherCellIdentifier = @"articlecell";
            ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:otherCellIdentifier ];
            if (cell == nil) {
                cell = [[ArticleTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:otherCellIdentifier];
                cell.delegate = self;
            }
            if (self.articleHTMLStr) {
                cell.htmlStr = self.articleHTMLStr;
            }
            return cell;
        }
        else if(self.mediaType==1)
        {
            static NSString *otherCellIdentifier = @"musiccell";
            MusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:otherCellIdentifier ];
            if (cell == nil) {
                cell = [[MusicTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:otherCellIdentifier];
                cell.delegate = self;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.currentTrack) {
                cell.theTrack = self.currentTrack;
            }
            if (self.isSecondaryPage) {
                cell.backBtn.hidden = NO;
            }
            else
                cell.backBtn.hidden = YES;
            return cell;
        }
        else
        {
            static NSString *otherCellIdentifier = @"piccell";
            PicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:otherCellIdentifier ];
            if (cell == nil) {
                cell = [[PicTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:otherCellIdentifier];
                cell.delegate = self;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.picInfo = self.currentPicInfo;
            return cell;
        }

    }
    else
    {
        static NSString *otherCellIdentifier = @"textcell";
        TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:otherCellIdentifier ];
        if (cell == nil) {
            cell = [[TextTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:otherCellIdentifier];
            cell.delegate = self;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.mediaType==1) {
            cell.des = self.currentTrack.des;
        }
        else if (self.mediaType==2){
            cell.des = self.currentPicInfo.des;
        }
//        cell.picInfo = self.currentPicInfo;
        return cell;
    }
    
}
-(void)scrollViewWillBeginDragging:(nonnull UIScrollView *)scrollView
{
    lastOffsetY = scrollView.contentOffset.y;
}
-(void)scrollViewDidScroll:(nonnull UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.tableview]) {
        if (self.mediaType==0) {
            //        NSLog(@"contentoffset:%f",scrollView.contentOffset.y);
            if (scrollView.contentOffset.y>lastOffsetY&&self.moreBtn.tag==1) {
                self.moreBtn.tag = 2;
                self.moreBtn.hidden = NO;
                self.moreBtn.alpha = 1;
                
                self.backBtn.tag = 10;
                self.backBtn.hidden = NO;
                self.backBtn.alpha = 1;
                
                [UIView animateWithDuration:0.5 animations:^{
                    self.moreBtn.alpha = 0;
                    self.backBtn.alpha = 0;
                } completion:^(BOOL finished) {
                    self.moreBtn.hidden = YES;
                    self.backBtn.hidden = YES;
                }];
                
            }
            else if(scrollView.contentOffset.y<lastOffsetY&&self.moreBtn.tag==2){
                self.moreBtn.tag = 1;
                self.moreBtn.hidden = NO;
                self.moreBtn.alpha = 0;
                
                self.backBtn.tag = 9;
                self.backBtn.hidden = NO;
                self.backBtn.alpha = 0;
                
                [UIView animateWithDuration:0.5 animations:^{
                    self.moreBtn.alpha = 1;
                    self.backBtn.alpha = 1;
                } completion:^(BOOL finished) {
                    self.moreBtn.hidden = NO;
                    self.backBtn.hidden = NO;
                }];
            }
            
            
        }

    }
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    self.moreBtn.tag = 1;
    self.moreBtn.hidden = NO;
    self.moreBtn.alpha = 0;
    
    self.backBtn.tag = 9;
    self.backBtn.hidden = NO;
    self.backBtn.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.moreBtn.alpha = 1;
        self.backBtn.alpha = 1;
    } completion:^(BOOL finished) {
        self.moreBtn.hidden = NO;
        self.backBtn.hidden = NO;
    }];
}
-(void)moreBtnClicked:(id)sender
{
    _maskControl = [[FSMaskControl alloc] initWithContainerView:self.moreView];
    
    _maskControl.didDismissHandler = ^ {
        [UIView animateWithDuration:.5f animations:^{
            
        }];
    };
    [_maskControl showInTargetView];
    
}
-(void)articleClickedPicIndex:(int)index withArray:(NSArray *)array
{
//    NSLog(@"clicked index %d , array:%@",index,array);
    NSMutableArray * photosURLArray = [NSMutableArray array];
    for (NSString *str in array) {
        NSURL *url = [NSURL URLWithString:str];
        [photosURLArray addObject:url];
    }
    
    ACImageBrowser *browser = [[ACImageBrowser alloc] initWithImagesURLArray:photosURLArray];
    browser.delegate = self;
    //browser.fullscreenEnable = NO;
    [browser setPageIndex:index];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.navigationBarHidden = YES;
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nc animated:YES completion:nil];
}
//- (void) viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
//    [self becomeFirstResponder];
//}
//
//- (void) viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
//    [self resignFirstResponder];
//}
//
//- (BOOL)canBecomeFirstResponder
//{
//    return YES;
//}
-(void)resetCellHeightWithContentSizeH:(CGFloat)height
{
    self.rowHeight = height;
//    self.tableview.contentSize = CGSizeMake(ScreenWidth-20, height+40);
    [self.tableview reloadData];
}

-(void)toTextView
{
    [self.cms flipTouched:nil];
}

-(void)imageLoaded:(UIImage *)image
{
    
}
-(void)backBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
