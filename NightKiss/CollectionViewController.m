//
//  CollectionViewController.m
//  NightKiss
//
//  Created by Tolecen on 15/7/5.
//  Copyright © 2015年 Tolecen. All rights reserved.
//

#import "CollectionViewController.h"
#import "SDWebImageOperation.h"
#import "UIImageView+WebCache.h"
@interface HCell : UICollectionViewCell
@property (nonatomic,retain)UIImageView * albumView;
@property (nonatomic,retain)UILabel * desL;
@property (nonatomic,retain)UILabel * timeL;

@end
@implementation HCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        float myWidth = (ScreenWidth-30)/2;
        
        UIView * b = [[UIView alloc] initWithFrame:CGRectMake(0, 0, myWidth, myWidth)];
        b.backgroundColor = [UIColor whiteColor];
        b.layer.cornerRadius = 10;
        b.layer.masksToBounds = YES;
        [self.contentView addSubview:b];

        self.albumView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, myWidth, 2*myWidth/3)];
        self.albumView.backgroundColor = [UIColor colorWithWhite:200/255.0f alpha:1];
        [b addSubview:self.albumView];
        
        
        self.desL = [[UILabel alloc] initWithFrame:CGRectMake(5, myWidth-(myWidth/3-10)/2-5, myWidth-10, (myWidth/3-10)/2)];
        self.desL.textColor = [UIColor colorWithWhite:120/255.0f alpha:1];
        self.desL.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.desL];
        self.desL.text = @"看着鱼的猫咪，干瞪眼";
        
        self.timeL = [[UILabel alloc] initWithFrame:CGRectMake(5, 2*myWidth/3+5, myWidth-10, (myWidth/3-10)/2)];
        self.timeL.textColor = [UIColor colorWithRed:0.235 green:0.776 blue:1 alpha:1];
        self.timeL.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.timeL];
        self.timeL.text = @"June. 23, 2015";
    }
    return self;
}
@end

@implementation CollectionViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    UIImageView * h = [[UIImageView alloc] initWithFrame:self.view.frame];
    h.image = [UIImage imageNamed:@"background"];
    [self.view addSubview:h];
    
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    float width = (self.view.frame.size.width-30)/2;
    layout.itemSize = CGSizeMake(width,width);
    layout.sectionInset = UIEdgeInsetsMake(40, 10, 10, 10);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.contentView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.contentView.delegate = self;
    self.contentView.dataSource = self;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundView = nil;
    [self.view addSubview:self.contentView];
    self.contentView.showsHorizontalScrollIndicator = NO;
    [self.contentView registerClass:[HCell class] forCellWithReuseIdentifier:@"hccell"];
    
    
    self.bottomV = [[UIImageView alloc] initWithFrame:CGRectMake(0, ScreenHeight-60, ScreenWidth, 60)];
    [self.bottomV setImage:[UIImage imageNamed:@"bottom_bar"]];
    [self.view addSubview:self.bottomV];
    self.bottomV.userInteractionEnabled = YES;
    self.bottomV.tag = 1;
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setFrame:CGRectMake(20, 10, 42, 42)];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"bottom_btn_back"] forState:UIControlStateNormal];
    [self.bottomV addSubview:self.backBtn];
    self.backBtn.alpha = 0.5;
    [self.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleL = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, ScreenWidth-120, 42)];
    titleL.backgroundColor = [UIColor clearColor];
    [titleL setTextAlignment:NSTextAlignmentCenter];
    [titleL setTextColor:[UIColor whiteColor]];
    titleL.font = [UIFont systemFontOfSize:17];
    [self.bottomV addSubview:titleL];
    titleL.text = self.title;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *hCellIdentifier = @"hccell";
    HCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:hCellIdentifier forIndexPath:indexPath];
    [cell.albumView sd_setImageWithURL:[NSURL URLWithString:@"http://f0.topit.me/0/2d/1c/11082632864a51c2d0l.jpg"]];
//    cell.albumView.sd_imageURL = [NSURL URLWithString:@"http://i9.topit.me/9/12/af/1108263372db4af129o.jpg"];
//    cell.headView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?imageView2/2/w/50",petalk.petInfo.headImgURL]];
//    cell.nameL.text = petalk.petInfo.nickname;
//    cell.timesL.text = [NSString stringWithFormat:@"%@人浏览",petalk.browseNum];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)scrollViewWillBeginDragging:(nonnull UIScrollView *)scrollView
{
    lastOffsetY = scrollView.contentOffset.y;
}
-(void)scrollViewDidScroll:(nonnull UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y>lastOffsetY&&self.bottomV.tag==1) {
        self.bottomV.tag = 2;
        self.bottomV.hidden = NO;
//        self.moreBtn.alpha = 1;
        [UIView animateWithDuration:0.3 animations:^{
            self.bottomV.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 60);
        } completion:^(BOOL finished) {
//            self.moreBtn.hidden = YES;
        }];
        
    }
    else if(scrollView.contentOffset.y<lastOffsetY&&self.bottomV.tag==2){
        self.bottomV.tag = 1;
        self.bottomV.hidden = NO;
//        self.moreBtn.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            self.bottomV.frame = CGRectMake(0, ScreenHeight-60, ScreenWidth, 60);
        } completion:^(BOOL finished) {
        }];
    }
        
        
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;
{
    self.bottomV.tag = 1;
    self.bottomV.hidden = NO;
    //        self.moreBtn.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomV.frame = CGRectMake(0, ScreenHeight-60, ScreenWidth, 60);
    } completion:^(BOOL finished) {
    }];
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
