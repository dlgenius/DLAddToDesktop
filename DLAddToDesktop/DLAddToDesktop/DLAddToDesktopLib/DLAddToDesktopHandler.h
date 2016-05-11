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
 *	@brief	通过Safari添加快捷方式到桌面,如未安装应用会跳转到应用下载地址，如安装应用，会直接打开应用
 *
 *	@param 	dataURISchemeImage   data URI scheme
 *	@param 	title                快捷方式桌面名称
 *	@param 	urlScheme            ios APP的URL Schemes
 *	@param 	appDownloadUrl       应用下载地址

 *
 *	@return	void
 */
- (void)addToDesktopWithDataURISchemeImage:(NSString *)dataURISchemeImage title:(NSString *)title urlScheme:(NSString *)urlScheme appDownloadUrl:(NSString *)appDownloadUrl;



@end
