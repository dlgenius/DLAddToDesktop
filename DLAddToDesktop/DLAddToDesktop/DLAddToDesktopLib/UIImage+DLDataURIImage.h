//
//  UIImage.h
//  DLCreateShortcut
//
//  Created by donglei on 16/3/30.
//  Copyright © 2016年 DL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DLDataURIImage)

/**
 *	@brief	生成Data URL Scheme 形式的图片字符串
 *
 *	@return	Data URL Scheme 形式的图片字符串
 */
- (NSString *)dataURISchemeImage;

@end
