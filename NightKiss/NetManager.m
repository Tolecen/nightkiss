//
//  NetManager.m
//  NightKiss
//
//  Created by Tolecen on 15/7/7.
//  Copyright (c) 2015年 Tolecen. All rights reserved.
//

#import "NetManager.h"
static inline NSString * get_uuid()

{
    
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    
    CFRelease(uuid_ref);
    
    NSString *uuid =  [[NSString  alloc]initWithCString:CFStringGetCStringPtr(uuid_string_ref, 0) encoding:NSUTF8StringEncoding];
    
    uuid = [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    CFRelease(uuid_string_ref);
    
    return uuid;
    
}
@implementation NetManager
+(NSMutableDictionary *)commonDict
{
    NSMutableDictionary * commonDict =[NSMutableDictionary dictionary];
    [commonDict setObject:@"10000000000" forKey:@"sim"];
    [commonDict setObject:Channel forKey:@"channel"];
    [commonDict setObject:CurrentVersion forKey:@"version"];
    [commonDict setObject:DeviceModel forKey:@"model"];
    [commonDict setObject:[@"iOS " stringByAppendingString:SystemVersion] forKey:@"platform"];
    [commonDict setObject:@"0.0.0.0" forKey:@"ipAddr"];
    [commonDict setObject:@"0:0:0:0" forKey:@"macAddr"];
    
    NSString * imeiStr = @"";
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        imeiStr = idfa;
        [commonDict setObject:idfa forKey:@"imei"];
        //        NSLog(@"IDFAAA:%@",idfa);
    }

    [commonDict setObject:@"00000000" forKey:@"imsi"];
    
    NSString * dontknowwhat = [SFHFKeychainUtils getPasswordForUsername:@"NIGHTKISS" andServiceName:@"NIGHTKISSKEYCHAINTOLECENWRITE" error:nil];
    if (dontknowwhat) {
        //        [SFHFKeychainUtils deleteItemForUsername:@"CHONGWUSHUO" andServiceName:@"CHONGWUSHUOKEYCHAINTOLECENWRITE" error:nil];
        [commonDict setObject:dontknowwhat forKey:@"keyChain"];
        //        NSLog(@" I have the keychain,CHONGWUSHUOKEYCHAINTOLECENWRITE,%@",dontknowwhat);
    }
    else
    {
        NSString * whatstr = [get_uuid() stringByAppendingString:imeiStr];
        //        NSLog(@" I don't have the keychain,CHONGWUSHUOKEYCHAINTOLECENWRITE,but I have written one with password:%@",whatstr);
        [SFHFKeychainUtils storeUsername:@"NIGHTKISS" andPassword:whatstr forServiceName:@"NIGHTKISSKEYCHAINTOLECENWRITE" updateExisting:YES error:nil];
    }
    
    
    
    return commonDict;
}

+(void)requestWithReqPath:(NSString *)reqPath Parameters:(NSDictionary *)parameters  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:[BaseURL stringByAppendingString:reqPath]]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    [httpClient postPath:@"" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSString *resText = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary * dict = [resText JSONValue];
        NSLog(@"req dict:%@",dict);
//        NSLog(@"dict:%@; parameters:%@",dict,parameters);
//        if ([[dict objectForKey:@"error"] isEqualToString:@"200"]) {
//            if (success) {
                success(operation,dict);
//            }
//        }
//        else if ([[dict objectForKey:@"error"] isEqualToString:@"503"]) {
//            NSError * aError = [NSError errorWithDomain:[dict objectForKey:@"message"] code:[[dict objectForKey:@"error"] integerValue] userInfo:nil];
//            if (failure) {
//                failure(operation,aError);
//            }
//            [NetServer tokenTimeOut];
//        }
//        else
//        {
//            NSError * aError = [NSError errorWithDomain:[dict objectForKey:@"message"] code:[[dict objectForKey:@"error"] integerValue] userInfo:nil];
//            if (failure) {
//                failure(operation,aError);
//            }
//        }
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@",error);
        if (failure) {
            failure(operation,error);
        }
//        [SVProgressHUD showErrorWithStatus:@"网络请求异常，请确认网络连接正常"];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    
    
}
@end
