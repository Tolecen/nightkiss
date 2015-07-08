//
//  XLProgressView.m
//  NightKiss
//
//  Created by Tolecen on 15/7/8.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import "XLProgressView.h"
@interface XLProgressView()
{
    float myWidth;
    float myHeight;
    
    BOOL dragBegan;
}
@property (nonatomic,strong)UIImageView * coverSliderView;
@end
@implementation XLProgressView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        myWidth = frame.size.width;
        myHeight = frame.size.height;
        self.trackImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,(frame.size.height-6)/2, frame.size.width, 6)];
        self.trackImageView.backgroundColor = [UIColor grayColor];
        self.trackImageView.layer.cornerRadius = 3;
        self.trackImageView.layer.masksToBounds = YES;
        [self addSubview:self.trackImageView];
        
        self.bufferImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (frame.size.height-6)/2, 0, 6)];
        self.bufferImageView.backgroundColor = [UIColor yellowColor];
        self.bufferImageView.layer.cornerRadius = 3;
        self.bufferImageView.layer.masksToBounds = YES;
        [self addSubview:self.bufferImageView];
        
        self.progressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (frame.size.height-6)/2, 0, 6)];
        self.progressImageView.backgroundColor = [UIColor blueColor];
        self.progressImageView.layer.cornerRadius = 3;
        self.progressImageView.layer.masksToBounds = YES;
        [self addSubview:self.progressImageView];
        
        self.sliderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        self.sliderImageView.backgroundColor = [UIColor purpleColor];
        [self addSubview:self.sliderImageView];
        
        self.coverSliderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [self.coverSliderView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.coverSliderView];
        self.coverSliderView.userInteractionEnabled = YES;
    }
    return self;
}
-(void)setSliderImage:(UIImage *)image
{
    [self.sliderImageView setImage:image];
    [self.sliderImageView setFrame:CGRectMake(self.sliderImageView.frame.origin.x, (myHeight-image.size.height)/2, image.size.width, image.size.height)];
}
-(void)setBufferValue:(CGFloat)bufferValue
{
    [self.bufferImageView setFrame:CGRectMake(0, self.bufferImageView.frame.origin.y, myWidth*bufferValue, self.bufferImageView.frame.size.height)];
}
-(void)setProgressValue:(CGFloat)progressValue
{
    if (dragBegan) {
        return;
    }
    [self.progressImageView setFrame:CGRectMake(0, self.progressImageView.frame.origin.y, myWidth*progressValue, self.bufferImageView.frame.size.height)];
    [self.sliderImageView setFrame:CGRectMake((myWidth-self.sliderImageView.frame.size.width)*progressValue, self.sliderImageView.frame.origin.y, self.sliderImageView.frame.size.width, self.sliderImageView.frame.size.height)];
    [self.coverSliderView setCenter:self.sliderImageView.center];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    if ([[touch view] isEqual:self.coverSliderView]) {
        dragBegan = YES;
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    if (point.x<self.sliderImageView.frame.size.width/2) {
        point.x = self.sliderImageView.frame.size.width/2;
    }
    else if (point.x>myWidth-self.sliderImageView.frame.size.width/2)
    {
        point.x = myWidth-self.sliderImageView.frame.size.width/2;
    }
    [self.sliderImageView setCenter:CGPointMake(point.x, self.sliderImageView.center.y)];
    [self.coverSliderView setCenter:CGPointMake(point.x, self.sliderImageView.center.y)];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
