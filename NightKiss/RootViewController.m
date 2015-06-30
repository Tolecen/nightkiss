//
//  RootViewController.m
//  TalkingPet
//
//  Created by wangxr on 14-7-7.
//  Copyright (c) 2014年 wangxr. All rights reserved.
//

#import "RootViewController.h"
#import "MenuViewController.h"
#import "ViewController.h"
@interface RootViewController ()
{
    MenuViewController * menuVC;
    ViewController * mainVC;
    
}

@end

@implementation RootViewController
static RootViewController* rootViewController;
+ (RootViewController*)sharedRootViewController
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        rootViewController=[[self alloc] initWithNibName:nil bundle:nil];
        
    });
    return rootViewController;
}

- (BOOL)shouldAutorotate
{
    return self.currentViewController.shouldAutorotate;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return self.currentViewController.supportedInterfaceOrientations;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mainVC = [[ViewController alloc] init];
    self.mainNavi = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.mainNavi.navigationBarHidden = YES;
    menuVC = [[MenuViewController alloc]init];
    
    self.sideMenu = [[RESideMenu alloc] initWithContentViewController:self.mainNavi leftMenuViewController:nil rightMenuViewController:menuVC];
    _sideMenu.backgroundImage = [UIImage imageNamed:@"background"];
    [self addChildViewController:_sideMenu];
    [_sideMenu.view setFrame:self.view.bounds];
    [self.view addSubview:_sideMenu.view];
    [_sideMenu didMoveToParentViewController:self];
    
}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
