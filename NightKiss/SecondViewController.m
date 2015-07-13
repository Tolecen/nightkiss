//
//  SecondViewController.m
//  NightKiss
//
//  Created by Tolecen on 15/7/12.
//  Copyright © 2015年 Tolecen. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * h = [[UIImageView alloc] initWithFrame:self.view.frame];
    h.image = [UIImage imageNamed:@"background"];
    [self.view addSubview:h];
    
    [self.view sendSubviewToBack:h];

    
}
@end
