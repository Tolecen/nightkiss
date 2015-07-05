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
#import "Track.h"
#import "TFHpple.h"
#import "UIImageView+WebCache.h"
#import "ACImageBrowser.h"
#import "MediaCellDelegate.h"
#import "MoreOperationView.h"
@interface ViewController ()<ArticleCellDelegate,ACImageBrowserDelegate,MediaCellDelegate>
{
    float lastOffsetY;
}
@property (nonatomic,strong)Track * currentTrack;
@property (nonatomic,strong)MoreOperationView * moreView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mediaType = 0;
    NSString * s = [[NSUserDefaults standardUserDefaults] objectForKey:@"mediaType"];
    if (s) {
        if ([s intValue]==0) {
            self.mediaType = 1;
        }
        else
            self.mediaType = 0;
    }
 
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",self.mediaType] forKey:@"mediaType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
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
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(10, ScreenHeight, ScreenWidth-20, ScreenHeight-20) style:UITableViewStylePlain];
//    self.tableview.rowHeight = 200;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    self.tableview.backgroundView = nil;
    self.tableview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableview];
    
    UIImageView * topv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-20, 30*(ScreenWidth-20)/732)];
    [topv setImage:[UIImage imageNamed:@"tvtop"]];
    self.tableview.tableHeaderView = topv;
    
    UIImageView * btv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-20, 30*(ScreenWidth-20)/732)];
    [btv setImage:[UIImage imageNamed:@"tvbottom"]];
    self.tableview.tableFooterView = btv;
    
    self.tableview.contentInset = UIEdgeInsetsMake(20, 0, 20, 0);
    
    
    
    
    [self.shadowAnimation start];
    
    _moreView = [[MoreOperationView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    __weak __typeof(self) wSelf = self;
    [_moreView setDismissHandle:^(NSInteger index) {
        NSLog(@"theIndex:%ld",(long)index);
        [wSelf.maskControl dismissIndex:index];
    }];
    
    //暂时延时调用，应该是内容加载完成之后调用，之前给个动画加载中...
    [self performSelector:@selector(appearTheTable) withObject:nil afterDelay:3];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)dismissAtIndex:(NSInteger)index
{
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
            
             [self.tableview reloadData];
        }
    }
   
    NSLog(@"dd%f,%f,%f",self.view.frame.size.width,ScreenWidth,ScreenHeight);

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
                         [self.tableview setFrame:CGRectMake(10, 20, ScreenWidth-20, ScreenHeight-20)];
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
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.mediaType==0) {
        return self.rowHeight;
    }
    else
        return NormalCellHeight;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    else
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
        return cell;
    }

}
-(void)scrollViewWillBeginDragging:(nonnull UIScrollView *)scrollView
{
    lastOffsetY = scrollView.contentOffset.y;
}
-(void)scrollViewDidScroll:(nonnull UIScrollView *)scrollView
{
    if (self.mediaType==0) {
        NSLog(@"contentoffset:%f",scrollView.contentOffset.y);
        if (scrollView.contentOffset.y>lastOffsetY&&self.moreBtn.tag==1) {
            self.moreBtn.tag = 2;
            self.moreBtn.hidden = NO;
            self.moreBtn.alpha = 1;
            [UIView animateWithDuration:0.5 animations:^{
                self.moreBtn.alpha = 0;
            } completion:^(BOOL finished) {
                self.moreBtn.hidden = YES;
            }];
            
        }
        else if(scrollView.contentOffset.y<lastOffsetY&&self.moreBtn.tag==2){
            self.moreBtn.tag = 1;
            self.moreBtn.hidden = NO;
            self.moreBtn.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.moreBtn.alpha = 1;
            } completion:^(BOOL finished) {
                self.moreBtn.hidden = NO;
            }];
        }
        
            
    }
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    self.moreBtn.tag = 1;
    self.moreBtn.hidden = NO;
    self.moreBtn.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.moreBtn.alpha = 1;
    } completion:^(BOOL finished) {
        self.moreBtn.hidden = NO;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
