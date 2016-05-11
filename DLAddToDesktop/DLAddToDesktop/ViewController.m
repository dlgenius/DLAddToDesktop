//
//  ViewController.m
//  DLAddToDesktop
//
//  Created by donglei on 16/4/1.
//  Copyright © 2016年 DL. All rights reserved.
//

#import "ViewController.h"
#import "DLAddToDesktopHandler.h"
#import "UIImage+DLDataURIImage.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addToDesktop:(id)sender {
    
   DLAddToDesktopHandler *handler = [DLAddToDesktopHandler sharedInsance];
    NSString *imageString = [[UIImage imageNamed:@"webIcon"] dataURISchemeImage];
    [handler addToDesktopWithDataURISchemeImage:imageString
                                          title:@"Donglei"
                                      urlScheme:@"DLAddToDesktop://"
                                 appDownloadUrl:@"https://appsto.re/cn/S8gTy.i"];

}
- (IBAction)addAnotherOne:(id)sender {
    
    DLAddToDesktopHandler *handler = [DLAddToDesktopHandler sharedInsance];
    NSString *imageString = [[UIImage imageNamed:@"webIcon1"] dataURISchemeImage];
    [handler addToDesktopWithDataURISchemeImage:imageString
                                          title:@"Donglei"
                                      urlScheme:@"DLAddToDesktop://"
                                 appDownloadUrl:@"https://appsto.re/cn/S8gTy.i"];
}

@end
