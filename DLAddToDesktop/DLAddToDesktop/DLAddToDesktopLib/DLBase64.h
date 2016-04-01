//
//  DLBase64.h
//  security
//
//  Created by donglei on 14-3-4.
//  Copyright (c) 2014年 donglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMBase64.h"

@interface DLBase64 : NSObject

/**
 *	@brief	对string进行base64加密
 *
 *	@param 	input 	未加密的字符串
 *
 *	@return	base64加密后的字符串
 */
+(NSString *)encodeBase64String:(NSString *)input;

/**
 *	@brief	对string进行base64解密
 *
 *	@param 	input 密的字符串
 *
 *	@return	base64解密后的字符串
 */
+(NSString *)decodeBase64String:(NSString *)input;

/**
 *	@brief	对data进行base64加密
 *
 *	@param 	input 未加密的字符串
 *
 *	@return	base64加密后的字符串
 */
+(NSString *)encodeBase64Data:(NSData *)input;

/**
 *	@brief	对data进行base64解密
 *
 *	@param 	input 加密的字符串
 *
 *	@return	base64解密后的字符串
 */
+(NSString *)decodeBase64Data:(NSData *)input;


@end
