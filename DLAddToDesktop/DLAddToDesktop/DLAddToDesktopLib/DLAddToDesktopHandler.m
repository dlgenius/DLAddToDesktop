//
// DLAddToDesktopHandler.m
//  DLCreateShortcut
//
//  Created by donglei on 16/3/30.
//  Copyright © 2016年 DL. All rights reserved.
//

#import "DLAddToDesktopHandler.h"
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "DLBase64.h"


#ifdef DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_WARN;
#endif

#define DLCSTitle                   @"DLCSTitle"
#define DLCSImageData               @"DLCSImageData"
#define DLCSAPPScheme               @"DLCSAPPScheme"
#define DLCSDataURISchemeContent    @"DLCSDataURISchemeContent"
#define DLAPPDownloadUrl            @"DLAPPDownloadUrl"


@interface DLAddToDesktopHandler()

@property(nonatomic, strong) HTTPServer *myHTTPServer;

@end


@implementation DLAddToDesktopHandler

#pragma mark - MainMethod

+(DLAddToDesktopHandler *)sharedInsance{
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    static DLAddToDesktopHandler *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[DLAddToDesktopHandler alloc] init];
    });
    
    return _sharedInstance;
}

- (void)addToDesktopWithDataURISchemeImage:(NSString *)dataURISchemeImage title:(NSString *)title urlScheme:(NSString *)urlScheme appDownloadUrl:(NSString *)appDownloadUrl{

    [self addToDesktopWithDataURISchemeImage:dataURISchemeImage
                                         title:title
                                     urlScheme:urlScheme
                                appDownloadUrl:appDownloadUrl
                                     localPort:1077];
}

- (void)addToDesktopWithDataURISchemeImage:(NSString *)dataURISchemeImage title:(NSString *)title urlScheme:(NSString *)urlScheme  appDownloadUrl:(NSString *)appDownloadUrl localPort:(int)localPort{
    
    [self configHttpServerWithPort:localPort];
    
    NSString *contentHtmlString = [self contentHtmlWithBase64Image:dataURISchemeImage title:title appScheme:urlScheme appDownloadUrl:appDownloadUrl];
    
    contentHtmlString = [DLBase64 encodeBase64String:contentHtmlString];
    NSString *DataURIString = [NSString stringWithFormat:@"0;data:text/html;charset=utf-8;base64,%@",contentHtmlString];
    
    NSString *indexHtmlString = [self indexHtmlWithBase64ContentString:DataURIString];
    
    [self writeHTMLToDocument:indexHtmlString];
    
    [self startServer];
    
    NSString *localAddress = [NSString stringWithFormat:@"http://127.0.0.1:%d",localPort];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:localAddress]];

}


#pragma mark - HttpServerMethod

- (void)configHttpServerWithPort:(int)port{
    

    if (!_myHTTPServer) {
        //config HttpServer
        _myHTTPServer = [[HTTPServer alloc] init];
        [_myHTTPServer setType:@"_http._tcp."];
        [_myHTTPServer setPort:port];
        
        //setWebPath
        NSString *serverWebPath = [self getServerWebPath];
        BOOL created = [[NSFileManager defaultManager] createDirectoryAtPath:serverWebPath withIntermediateDirectories:YES attributes:nil error:nil];
        if(created){
            [_myHTTPServer setDocumentRoot:serverWebPath];
        }
        
        DDLogInfo(@"SettingHttpServerPath:%@", serverWebPath);
    }
   
    DDLogInfo(@"myHTTPServer already started");
}

- (void)startServer{
    NSError *error;
    if([_myHTTPServer start:&error])
    {
        DDLogInfo(@"Started HTTP Server on port %hu", [_myHTTPServer listeningPort]);
    }
    else
    {
        DDLogError(@"Error starting HTTP Server: %@", error);
    }
}


#pragma mark - HTMLMethod

-(NSString *)contentHtmlWithBase64Image:(NSString *)base64ImageString title:(NSString *)title appScheme:(NSString *)scheme appDownloadUrl:(NSString *)appDownloadUrl{
    
    NSString *contentHtmlPath = [self getcontentHTMLTempletPath];
    NSString *contentHtmlString = [NSString stringWithContentsOfFile:contentHtmlPath encoding:NSUTF8StringEncoding error:nil];
    
    contentHtmlString = [contentHtmlString stringByReplacingOccurrencesOfString:DLCSImageData withString:base64ImageString];
    contentHtmlString = [contentHtmlString stringByReplacingOccurrencesOfString:DLCSTitle withString:title];
    contentHtmlString = [contentHtmlString stringByReplacingOccurrencesOfString:DLCSAPPScheme withString:scheme];
    contentHtmlString = [contentHtmlString stringByReplacingOccurrencesOfString:DLAPPDownloadUrl withString:appDownloadUrl];
   
    return contentHtmlString;

}

-(NSString *)indexHtmlWithBase64ContentString:(NSString *)contentString{
    NSString *indexHtmlPath = [self getIndexHTMLTempletPath];
    NSString *indexHtmlString = [NSString stringWithContentsOfFile:indexHtmlPath encoding:NSUTF8StringEncoding error:nil];
    
    indexHtmlString = [indexHtmlString stringByReplacingOccurrencesOfString:DLCSDataURISchemeContent withString:contentString];
    
    return indexHtmlString;

}

#pragma mark - FileMethod

- (void)writeHTMLToDocument:(NSString *)htmlString{
    NSString *serverWebPath = [self getServerWebPath];
    BOOL created = [[NSFileManager defaultManager] createDirectoryAtPath:serverWebPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    if(created){
        NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
        BOOL writeToDucument = [data writeToFile:[NSString stringWithFormat:@"%@/index.html",serverWebPath] atomically:YES];
        if (writeToDucument) {
            DDLogInfo(@"indexHtmlAlreadyWriteToDocument");
        }
    }
    
}

- (NSString *)getServerWebPath{
    
    NSString *serverWebPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"DLCreateShortcutWebPath"];
    
    return serverWebPath;
}

- (NSString *)getIndexHTMLTempletPath{
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"/index.html"];
    
    return path;
}

- (NSString *)getcontentHTMLTempletPath{
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"/content.html"];
    
    return path;
}
@end
