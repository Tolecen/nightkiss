//
//  MoreOperationView.m
//  NightKiss
//
//  Created by Tolecen on 15/7/4.
//  Copyright © 2015年 Tolecen. All rights reserved.
//

#import "MoreOperationView.h"

@implementation MoreOperationView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction:)];
        [self addGestureRecognizer:tap];

    }
    return self;
}
- (void)closeAction:(UIButton *)sender {
    self.dismissHandle(0);
}

@end
