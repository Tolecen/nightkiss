//
//  MusicTableViewCell.h
//  NightKiss
//
//  Created by Tolecen on 15/7/1.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "Track.h"
#import "DOUAudioStreamer.h"
#import "DOUAudioVisualizer.h"
#import "DOUAudioFileProvider.h"

static void *kStatusKVOKey = &kStatusKVOKey;
static void *kDurationKVOKey = &kDurationKVOKey;
static void *kBufferingRatioKVOKey = &kBufferingRatioKVOKey;

@interface MusicTableViewCell : UITableViewCell
{
    NSTimer *_timer;
    
    DOUAudioStreamer *_streamer;
    DOUAudioVisualizer *_audioVisualizer;

}
@property (nonatomic,strong) UILabel * timeL;
@property (nonatomic,strong) EGOImageView * albumV;
@property (nonatomic,strong) UILabel * musicNameL;
@property (nonatomic,strong) UILabel * artistNameL;
@property (nonatomic,strong) UISlider * sliderV;
@property (nonatomic,strong) UIButton * playBtn;
@property (nonatomic,strong) Track * theTrack;
@property (nonatomic,strong) NSMutableDictionary * artDict;
@property (nonatomic,strong) UIActivityIndicatorView * loadingIndicaor;


- (void)_actionPlayPause:(id)sender;

@end
