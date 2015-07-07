//
//  NetManager.h
//  NightKiss
//
//  Created by Tolecen on 15/7/7.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AdSupport/AdSupport.h>
#import "AFNetworking.h"
#import "JSON.h"
#import "SFHFKeychainUtils.h"
@interface NetManager : NSObject
+(void)requestWithReqPath:(NSString *)reqPath Parameters:(NSDictionary *)parameters  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
