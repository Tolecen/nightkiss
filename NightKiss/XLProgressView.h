//
//  XLProgressView.h
//  NightKiss
//
//  Created by Tolecen on 15/7/8.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLProgressView : UIView
@property (nonatomic,strong)UIImageView * trackImageView;
@property (nonatomic,strong)UIImageView * progressImageView;
@property (nonatomic,strong)UIImageView * bufferImageView;
@property (nonatomic,strong)UIImageView * sliderImageView;
-(void)setBufferValue:(CGFloat)bufferValue;
-(void)setProgressValue:(CGFloat)progressValue;
@end
