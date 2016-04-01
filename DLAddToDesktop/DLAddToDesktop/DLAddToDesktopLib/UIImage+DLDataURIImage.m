//
//  UIImage.m
//  DLCreateShortcut
//
//  Created by donglei on 16/3/30.
//  Copyright © 2016年 DL. All rights reserved.
//

#import "UIImage+DLDataURIImage.h"

@implementation UIImage (DLDataURIImage)

- (NSString *)dataURISchemeImage{
    
    NSString *imageString = [UIImagePNGRepresentation(self) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSString *prefix = @"data:image/png;base64,";
    
    NSString *returnStr = [prefix stringByAppendingString:imageString];
    
    return returnStr;
}

@end
