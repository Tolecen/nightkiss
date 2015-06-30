//
//  BaseViewController.m
//  NightKiss
//
//  Created by Tolecen on 15/6/30.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        if(self.navigationController.viewControllers.count > 1)
        {
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }else
        {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
