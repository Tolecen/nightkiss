//
//  TextTableViewCell.m
//  NightKiss
//
//  Created by Tolecen on 15/7/8.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import "TextTableViewCell.h"

@implementation TextTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentTextV = [[UITextView alloc] initWithFrame:CGRectMake(10, 50, ScreenWidth-40, NormalCellHeight-50-10)];
        self.contentTextV.backgroundColor = [UIColor clearColor];
        self.contentTextV.font = [UIFont systemFontOfSize:14];
        self.contentTextV.textColor = [UIColor colorWithWhite:120/255.0f alpha:1];
        [self.contentView addSubview:self.contentTextV];
        self.contentTextV.editable = NO;
        
        
        UIButton * b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.backgroundColor = [UIColor clearColor];
        [b setTitle:@"返回" forState:UIControlStateNormal];
        [b setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [b.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [b setFrame:CGRectMake(ScreenWidth-20-10-60, 10, 60, 30)];
        [self.contentView addSubview:b];
        [b addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)back
{
    if ([self.delegate respondsToSelector:@selector(toTextView)]) {
        [self.delegate toTextView];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (!self.attriStr) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5;
        
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:14],
                                     NSForegroundColorAttributeName:[UIColor colorWithWhite:120/255.0f alpha:1],
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
        self.attriStr = [[NSAttributedString alloc] initWithString:self.des attributes:attributes];
    }
    self.contentTextV.attributedText = self.attriStr;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
