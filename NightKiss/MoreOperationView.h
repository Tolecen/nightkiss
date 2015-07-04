//
//  MoreOperationView.h
//  NightKiss
//
//  Created by Tolecen on 15/7/4.
//  Copyright © 2015年 Tolecen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreOperationView : UIView
@property (nonatomic, copy) void(^dismissHandle)(NSInteger index);
@end
