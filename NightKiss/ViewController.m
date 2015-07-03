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

@interface ViewController ()<ResetCellHeightDelegate>
{
}
@property (nonatomic,strong)Track * currentTrack;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mediaType = 1;
    
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
    
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    
    
    //暂时延时调用，应该是内容加载完成之后调用，之前给个动画加载中...
    [self performSelector:@selector(appearTheTable) withObject:nil afterDelay:3];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.currentTrack) {
        self.currentTrack = [[Track alloc] init];
        [self.currentTrack setArtist:@"陈慧娴"];
        [self.currentTrack setTitle:@"千千阙歌"];
        self.currentTrack.albumUrlStr = @"http://i2.sinaimg.cn/ent/x/2008-09-10/56225667ced245ba4910aa375b6c4df5.jpg";
        [self.currentTrack setAudioFileURL:[NSURL URLWithString:@"http://7d9jfr.com1.z0.glb.clouddn.com/qianqianquege.mp3"]];
        
//        [self.currentTrack setAudioFileURL:[NSURL URLWithString:@"http://7d9jfr.com1.z0.glb.clouddn.com/buyouyu.mp3"]];
        
         [self.tableview reloadData];
    }
    [self.shadowAnimation start];
   
    

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
        
        return cell;
    }
    else
    {
        static NSString *otherCellIdentifier = @"musiccell";
        MusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:otherCellIdentifier ];
        if (cell == nil) {
            cell = [[MusicTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:otherCellIdentifier];
//            cell.delegate = self;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.currentTrack) {
            cell.theTrack = self.currentTrack;
        }
        return cell;
    }

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
