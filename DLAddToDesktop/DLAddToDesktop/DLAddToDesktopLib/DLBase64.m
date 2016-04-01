//
//  DLBase64.m
//  security
//
//  Created by donglei on 14-3-4.
//  Copyright (c) 2014年 donglei. All rights reserved.
//

#import "DLBase64.h"
#import "CommonCrypto/CommonDigest.h"

@implementation DLBase64

+(NSString *)encodeBase64String:(NSString *)input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}
+(NSString *)decodeBase64String:(NSString *)input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeData:data];
    NSString *base64string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64string;
}
+(NSString *)encodeBase64Data:(NSData *)input
{
    NSData *data = [GTMBase64 encodeData:input];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
    
}
+(NSString *)decodeBase64Data:(NSData *)input
{
    NSData *data = [GTMBase64 decodeData:input];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}


@end
