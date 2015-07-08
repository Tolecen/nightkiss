//
//  PicTableViewCell.m
//  NightKiss
//
//  Created by Tolecen on 15/7/1.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import "PicTableViewCell.h"

@implementation PicTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.timeL = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 20)];
        [self.timeL setTextColor:[UIColor colorWithWhite:200/255.0f alpha:1]];
        [self.timeL setFont:[UIFont systemFontOfSize:15]];
        self.timeL.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.timeL];
        self.timeL.text = @"Apr. 12, 2015";
        
        self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        self.playBtn.backgroundColor = [UIColor redColor];
        [self.moreBtn setBackgroundImage:[UIImage imageNamed:@"bottom_btn_more2"] forState:UIControlStateNormal];
        [self.moreBtn setFrame:CGRectMake(ScreenWidth-40-42, NormalCellHeight-10-42, 42, 42)];
        [self.contentView addSubview:self.moreBtn];
        [self.moreBtn addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        self.artistL = [[UILabel alloc] initWithFrame:CGRectMake(10, self.moreBtn.frame.origin.y-10-20, ScreenWidth-40, 20)];
        self.artistL.textColor = [UIColor colorWithWhite:160/255.0f alpha:1];
        self.artistL.font = [UIFont systemFontOfSize:14];
        self.artistL.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.artistL];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.artistL.frame.origin.y-30, ScreenWidth-40, 30)];
        self.titleLabel.textColor = [UIColor colorWithWhite:160/255.0f alpha:1];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:self.titleLabel];
        
        self.picImageview = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.picImageview.backgroundColor = [UIColor colorWithWhite:240/255.0f alpha:1];
        [self.contentView addSubview:self.picImageview];
        self.picImageview.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picTouched)];
        [self.picImageview addGestureRecognizer:tap];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.picInfo) {
        self.titleLabel.text = self.picInfo.title;
        self.artistL.text = [@"by " stringByAppendingString:self.picInfo.artist];
        
        float remainH = NormalCellHeight-30-10-(NormalCellHeight-self.titleLabel.frame.origin.y)-10;
        if (self.picInfo.ratioWH<1) {
            float picW = remainH*self.picInfo.ratioWH;
            [self.picImageview setFrame:CGRectMake((ScreenWidth-20-picW)/2, 40, picW, remainH)];
        }
        else
        {
            float picH = (ScreenWidth-40)/self.picInfo.ratioWH;
            [self.picImageview setFrame:CGRectMake(10, (remainH-picH)/2+20, ScreenWidth-40, picH)];
            [self.titleLabel setFrame:CGRectMake(10, self.picImageview.frame.origin.y+picH+10, ScreenWidth-40, 20)];
            [self.artistL setFrame:CGRectMake(10, self.titleLabel.frame.origin.y+20+5, ScreenWidth-40, 20)];
            
        }
        [self.picImageview sd_setImageWithURL:[NSURL URLWithString:self.picInfo.imageUrl]];
    }

    
}
-(void)picTouched
{
    if ([self.delegate respondsToSelector:@selector(articleClickedPicIndex:withArray:)]) {
        [self.delegate articleClickedPicIndex:0 withArray:[NSArray arrayWithObject:self.picInfo.imageUrl]];
    }
}
-(void)moreBtnClicked:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(moreBtnClicked:)]) {
        [self.delegate moreBtnClicked:sender];
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
