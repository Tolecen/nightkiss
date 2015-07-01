//
//  MusicTableViewCell.m
//  NightKiss
//
//  Created by Tolecen on 15/7/1.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import "MusicTableViewCell.h"
#import <MediaPlayer/MediaPlayer.h>
@implementation MusicTableViewCell

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
        
        self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.playBtn.backgroundColor = [UIColor redColor];
        [self.playBtn setFrame:CGRectMake((ScreenWidth-20-60)/2, NormalCellHeight-30-60, 60, 60)];
        [self.contentView addSubview:self.playBtn];
        [self.playBtn addTarget:self action:@selector(_actionPlayPause:) forControlEvents:UIControlEventTouchUpInside];
        [self.playBtn setTitle:@"play" forState:UIControlStateNormal];
        
        
        self.sliderV = [[UISlider alloc] initWithFrame:CGRectMake(20.0, self.playBtn.frame.origin.y-40, ScreenWidth-20-40, 20.0)];
        [self.sliderV addTarget:self action:@selector(_actionSliderProgress:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:self.sliderV];
        
        self.artistNameL = [[UILabel alloc] initWithFrame:CGRectMake(0, self.sliderV.frame.origin.y-30, ScreenWidth-20, 20)];
        self.artistNameL.backgroundColor = [UIColor clearColor];
        self.artistNameL.font = [UIFont systemFontOfSize:14];
        self.artistNameL.textAlignment = NSTextAlignmentCenter;
        self.artistNameL.textColor = [UIColor colorWithWhite:180/255.0f alpha:1];
        [self.contentView addSubview:self.artistNameL];
        self.artistNameL.text = @"艺术家";
        
        self.musicNameL = [[UILabel alloc] initWithFrame:CGRectMake(0, self.artistNameL.frame.origin.y-25, ScreenWidth-20, 20)];
        self.musicNameL.backgroundColor = [UIColor clearColor];
        self.musicNameL.font = [UIFont boldSystemFontOfSize:16];
        self.musicNameL.textAlignment = NSTextAlignmentCenter;
        self.musicNameL.textColor = [UIColor colorWithWhite:120/255.0f alpha:1];
        [self.contentView addSubview:self.musicNameL];
        self.musicNameL.text = @"音乐名称是这里";
        
        float remianingH = self.musicNameL.frame.origin.y-30;
        float albumH = MIN(remianingH, ScreenWidth-20)-40;
        self.albumV = [[EGOImageView alloc] initWithFrame:CGRectMake((ScreenWidth-20-albumH)/2, (remianingH-albumH)/2+30, albumH, albumH)];
        self.albumV.layer.cornerRadius = albumH/2;
        self.albumV.layer.masksToBounds = YES;
        self.albumV.backgroundColor = [UIColor colorWithWhite:200/255.0f alpha:1];
        [self.contentView addSubview:self.albumV];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.theTrack) {
        [self.musicNameL setText:self.theTrack.title];
        [self.artistNameL setText:self.theTrack.artist];
        self.albumV.imageURL = [NSURL URLWithString:self.theTrack.albumUrlStr];
        [self setMediaInfo];
    }
    
}

- (void) setMediaInfo
{
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        
        
        [dict setObject:self.theTrack.title forKey:MPMediaItemPropertyAlbumTitle];
        [dict setObject:self.theTrack.artist forKey:MPMediaItemPropertyArtist];
        [dict setObject:[NSNumber numberWithInt:0] forKey:MPMediaItemPropertyPlaybackDuration];
        
        if (self.albumV.image) {
            MPMediaItemArtwork * mArt = [[MPMediaItemArtwork alloc] initWithImage:self.albumV.image];
            [dict setObject:mArt forKey:MPMediaItemPropertyArtwork];
        }
        
        [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = nil;
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
    }
}

- (void)_cancelStreamer
{
    if (_streamer != nil) {
        [_streamer pause];
        [_streamer removeObserver:self forKeyPath:@"status"];
        [_streamer removeObserver:self forKeyPath:@"duration"];
        [_streamer removeObserver:self forKeyPath:@"bufferingRatio"];
        _streamer = nil;
    }
}

- (void)_resetStreamer
{
    [self _cancelStreamer];
    
    if (!self.theTrack)
    {
        NSLog(@"no track now");
    }
    else
    {
        Track *track = self.theTrack;
  
        
        _streamer = [DOUAudioStreamer streamerWithAudioFile:track];
        [_streamer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kStatusKVOKey];
        [_streamer addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:kDurationKVOKey];
        [_streamer addObserver:self forKeyPath:@"bufferingRatio" options:NSKeyValueObservingOptionNew context:kBufferingRatioKVOKey];
        
        [_streamer play];
        
        [self _updateBufferingStatus];
        [self _setupHintForStreamer];
    }
}

- (void)_setupHintForStreamer
{
//    NSUInteger nextIndex = _currentTrackIndex + 1;
//    if (nextIndex >= [_tracks count]) {
//        nextIndex = 0;
//    }
    
    [DOUAudioStreamer setHintWithAudioFile:self.theTrack];
}

- (void)_timerAction:(id)timer
{
    if ([_streamer duration] == 0.0) {
        [self.sliderV setValue:0.0f animated:NO];
    }
    else {
        [self.sliderV setValue:[_streamer currentTime] / [_streamer duration] animated:YES];
    }
}

- (void)_updateStatus
{
    switch ([_streamer status]) {
        case DOUAudioStreamerPlaying:
//            [_statusLabel setText:@"playing"];
            [self.playBtn setTitle:@"Pause" forState:UIControlStateNormal];
            break;
            
        case DOUAudioStreamerPaused:
//            [_statusLabel setText:@"paused"];
            [self.playBtn setTitle:@"Play" forState:UIControlStateNormal];
            break;
            
        case DOUAudioStreamerIdle:
//            [_statusLabel setText:@"idle"];
            [self.playBtn setTitle:@"Play" forState:UIControlStateNormal];
            break;
            
        case DOUAudioStreamerFinished:
//            [_statusLabel setText:@"finished"];
            [self _resetStreamer];
//            [self _actionNext:nil];
            break;
            
        case DOUAudioStreamerBuffering:
//            [_statusLabel setText:@"buffering"];
            [self.playBtn setTitle:@"buffering" forState:UIControlStateNormal];
            break;
            
        case DOUAudioStreamerError:
//            [_statusLabel setText:@"error"];
            NSLog(@"error");
            break;
    }
}


- (void)_updateBufferingStatus
{
//    [_miscLabel setText:[NSString stringWithFormat:@"Received %.2f/%.2f MB (%.2f %%), Speed %.2f MB/s", (double)[_streamer receivedLength] / 1024 / 1024, (double)[_streamer expectedLength] / 1024 / 1024, [_streamer bufferingRatio] * 100.0, (double)[_streamer downloadSpeed] / 1024 / 1024]];
    NSLog(@"%@",[NSString stringWithFormat:@"Received %.2f/%.2f MB (%.2f %%), Speed %.2f MB/s", (double)[_streamer receivedLength] / 1024 / 1024, (double)[_streamer expectedLength] / 1024 / 1024, [_streamer bufferingRatio] * 100.0, (double)[_streamer downloadSpeed] / 1024 / 1024]);
    if ([_streamer bufferingRatio] >= 1.0) {
        NSLog(@"sha256: %@", [_streamer sha256]);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kStatusKVOKey) {
        [self performSelector:@selector(_updateStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }
    else if (context == kDurationKVOKey) {
        [self performSelector:@selector(_timerAction:)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }
    else if (context == kBufferingRatioKVOKey) {
        [self performSelector:@selector(_updateBufferingStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


-(void)destroyMusic
{
    [_timer invalidate];
    [_streamer stop];
    [self _cancelStreamer];
}


- (void)_actionPlayPause:(id)sender
{
    if (!_streamer) {
        [self _resetStreamer];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(_timerAction:) userInfo:nil repeats:YES];
//        [self.sliderV setValue:[DOUAudioStreamer volume]];
    }
    else{
        if ([_streamer status] == DOUAudioStreamerPaused ||
            [_streamer status] == DOUAudioStreamerIdle) {
            [_streamer play];
        }
        else {
            [_streamer pause];
        }
    }
}



- (void)_actionStop:(id)sender
{
    [_streamer stop];
}

- (void)_actionSliderProgress:(id)sender
{
    [_streamer setCurrentTime:[_streamer duration] * [self.sliderV value]];
}

- (void)_actionSliderVolume:(id)sender
{
    [DOUAudioStreamer setVolume:[self.sliderV value]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
