//
// DLAddToDesktopHandler.h
//  DLCreateShortcut
//
//  Created by donglei on 16/3/30.
//  Copyright © 2016年 DL. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DLAddToDesktopHandler : NSObject

/**
 *	@brief	创建DLAddToDesktopHandler单例
 *
 *	@return	DLAddToDesktopHandler单例
 */

+(DLAddToDesktopHandler *)sharedInsance;

/**
 *	@brief	通过Safari添加快捷方式到桌面
 *
 *	@param 	dataURISchemeImage   data URI scheme
 *	@param 	title                快捷方式桌面名称
 *	@param 	urlScheme            ios APP的URL Schemes
 *
 *	@return	void
 */
- (void)addToDesktopWithDataURISchemeImage:(NSString *)dataURISchemeImage title:(NSString *)title urlScheme:(NSString *)urlScheme;

@end
