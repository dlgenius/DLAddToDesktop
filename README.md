# DLAddToDesktop
iOS 添加到主屏幕/ iOS Add To Desktop
##基本实现思想

利用Safari自带的添加到主屏幕功能，有两种实现方案，

>实现方案一：

```
调用Safari访问外部页面，将外部页面作为快捷页面添加到桌面。
优点：实现简单，工作量少，页面灵活可随时更改。
缺点：无网状态下，无法生成快捷方式。
```

>实现方案二：

```
通过应用内部启动httpServer，调用safari访问localhost，同时，在主页通过跳转到新的Data URI页面。
优点：不需要服务器，没网也能完成操作。
缺点：依赖的类库较多，而且实现较麻烦。
```

##功能封装及技术实现
方案一比较简单，就不再多说了。
本文主要针对方案二，其中用到的一些知识包括HTML、cocoaHttpServer、Data URI Scheme等，关于Data URI Scheme相关知识，可以参考我的另一篇文章。
>封装方法

针对方案二，对功能进行了封装，仅需调用3行代码，即可实现动态添加快捷方式到桌面。

<img id="img" width="100" height="100" src="http://upload-images.jianshu.io/upload_images/1790518-fb43eb8c8afb94ad.gif?imageMogr2/auto-orient/strip">

###功能封装
>用到的一些类库

 * CocoaHTTPServer
 * GTMBase64
 



使用方式：
1.工程中导入CocoaHTTPServer、GTMBase64类库
2.将Demo中的DLAddToDesktopLib文件夹拷贝到工程中

![lib.png](http://upload-images.jianshu.io/upload_images/1790518-9371454439ce8c25.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

3.在需要添加到主页面的按钮事件中加入如下代码

```
 DLAddToDesktopHandler *handler = [DLAddToDesktopHandler sharedInsance];
    NSString *imageString = [[UIImage imageNamed:@"webIcon"] dataURISchemeImage];
    [handler addToDesktopWithDataURISchemeImage:imageString
                                            title:@"Donglei"
                                        urlScheme:@"DLAddToDesktop://"];
```

4.别忘记设置项目的URL Types


![URL Schemes.jpg](http://upload-images.jianshu.io/upload_images/1790518-356d2ba020ace279.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


下面是一些主要的方法，

```
/**
 *	@brief	创建DLCreateShortcutHandler单例
 *
 *	@return	DLCreateShortcutHandler单例
 */

+(DLCreateShortcutHandler *)sharedInsance;

/**
 *	@brief	通过Safari添加快捷方式到桌面
 *
 *	@param 	dataURISchemeImage   data URI scheme
 *	@param 	title                快捷方式桌面名称
 *	@param 	urlScheme            ios APP的URL Scheme
 *
 *	@return	void
 */
- (void)addToDesktopWithDataURISchemeImage:(NSString *)dataURISchemeImage title:(NSString *)title urlScheme:(NSString *)urlScheme;

```

```

/**
 *	@brief	生成Data URL Scheme 形式的图片字符串
 *
 *	@return	Data URL Scheme 形式的图片字符串
 */
- (NSString *)dataURISchemeImage;

```
