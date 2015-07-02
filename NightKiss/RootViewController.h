//
//  RootViewController.h
//  TalkingPet
//
//  Created by wangxr on 14-7-7.
//  Copyright (c) 2014年 wangxr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "DOUAudioStreamer.h"
#import "MusicTableViewCell.h"
@interface RootViewController : UIViewController
@property (nonatomic,assign)UIViewController * currentViewController;
@property (nonatomic,retain)RESideMenu * sideMenu;
@property (nonatomic,strong)UINavigationController * mainNavi;
@property (nonatomic,strong)MusicTableViewCell * currentPlayCell;
+ (RootViewController*)sharedRootViewController;

@end
