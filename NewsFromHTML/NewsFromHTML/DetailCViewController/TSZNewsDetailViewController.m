//
//  TSZNewsDetailViewController.m
//  NewsFromHTML
//
//  Created by Tsz on 15/11/17.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import "TSZNewsDetailViewController.h"
#import "TSZHeadline.h"
#import "AFNetworking.h"
#import "TSZHTTPManager.h"
#import "TSZNewsDetailImage.h"
#import "MBProgressHUD+MJ.h"
#import "TSZNewsDetail.h"
#import "TSZStatusBarHUD.h"

@interface TSZNewsDetailViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;



@end
@implementation TSZNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 发送一个get请求,获得新闻的详情数据
    // 地址: http://c.m.163.com/nc/article/{docid}/full.html
    //一般做法
    
    self.title  = @"新闻详情";
    
    self.webView.delegate = self;
    
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.headLine.docid];
    
    NSLog(@"%@" , url);
    
    [[TSZHTTPManager manager] GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        self.detail  = [TSZNewsDetail detailWithDict:responseObject[self.headLine.docid]];
        
        [self showDetailInfo];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        NSLog(@"%@" , error);
        
    }];
}


//显示 详情
- (void)showDetailInfo{
    [self.webView loadHTMLString:self.detail.body baseURL:nil];
    
    //1、使用代码去实现新闻的详情
    NSMutableString *html = [NSMutableString string];
    
    //头部内容
    [html appendString:@"<html>"];
    
    [html appendString:@"<head>"];
    
    //导入css层叠样式表
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">" ,[[NSBundle mainBundle] URLForResource:@"TSZDetail.css" withExtension:nil]];
    
    [html appendString:@"</head>"];
    
    //具体的内容
    [html appendString:@"<body>"];
    
    //把图片插入到<!--IMG#0-->标签的位置
    
    [html appendString: [self setupBoby]];
    
    
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    //显示网页
    [self.webView loadHTMLString:html baseURL:nil];
    
}

//设置 body
- (NSString *)setupBoby{
    NSMutableString *body = [NSMutableString string];
    
    //拼接标题
    [body appendFormat:@"<div class=\"title\"> %@</div>",self.detail.title];
    
    //拼接时间
    [body appendFormat:@"<div class=\"time\">%@</div>" , self.detail.ptime];
    [body appendString:self.detail.body];
    
    for (TSZNewsDetailImage  *img in self.detail.img) {
        
        NSMutableString *imgHtml = [NSMutableString string];
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        
        //根据返回的图像大小 限制显示的大小
        NSArray *pixel = [img.pixel componentsSeparatedByString:@"*"];
        int width = [[pixel firstObject] intValue];
        int height = [[pixel lastObject] intValue];
        int maxWidth = [UIScreen mainScreen].bounds.size.width * 0.7;
        
        if (width > maxWidth) {
            height  = height *maxWidth / width;
            width = maxWidth;
        }
        
        //增加单击方法，使用js 代码
        /*
         通用url的设计
         协议固定: hm:
         一般有2个参数
         1> 方法名
         2> 方法参数 (字符串类型)
         */
//        NSString *onload = @"this.onclick = function() {"
//     "window.location.href = 'tsz:call:&10086'" // 1> 打电话方法,有参数
//        "window.location.href = 'tsz:sendMsg:&10010'" // 2> 发信息方法,有参数
//          "window.location.href = 'tsz:shutdown'"
//        "};"; // 3> 关机方法,无参数
        
        // 注意网络的网址 浏览器会自动把大写转为小写
        NSString *onload = @"this.onclick = function(){"
                        "window.location.href = 'TSZ:saveImageToAlbum:&' + this.src"
                        "};";
        
        
        [imgHtml appendFormat:@"<img  onload=\"%@\" width=\"%d\" height=\"%d\" src=\"%@\">",onload , width,height ,img.src];
        
        
        
        [imgHtml appendString:@"</div>"];
        
        [body  replaceOccurrencesOfString:img.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;
}

#pragma mark: 代码实现保存
- (void)saveImageToAlbum:(NSString *)imgStr{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"你确定要保存吗" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        //保存
        // 保存图片到相册方法二  直接从UIWebView的缓存中获取
        // UIWebView 的缓存由 NSURLCache 来管理
        NSURLCache *cache = [NSURLCache sharedURLCache];
        // 从网页的缓存中取得图片
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imgStr]];
        NSCachedURLResponse *response = [cache cachedResponseForRequest:request];
        NSData *imageData = response.data;
        
        // 保存图片
        UIImage *image = [UIImage imageWithData:imageData];
        
        UIImageWriteToSavedPhotosAlbum(image, self , @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    if (error != NULL)
    {
        
//        [MBProgressHUD showSuccess:@"保存失败!" ];
        [TSZStatusBarHUD showSuccess:@"保存失败"];
        
    }
    else
    {
//        [MBProgressHUD showError:@"保存成功!" ];
        [TSZStatusBarHUD showError:@"保存成功"];
        //模拟下载
//        [TSZStatusBarHUD showLoading:@"大爷正在加载别催..."];
    }
}

#pragma mark: UIWebViewDelegate
/**
 调用 : 每当webView发送一个请求之前都会先调用这个方法
 request : 即将发送的请求
 BOOL : Yes : 允许发送这个请求  No : 禁止发送这个请求
 navigationType : 是否在新窗口中打开
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *url = request.URL.absoluteString;

    NSRange range = [url rangeOfString:@"tsz:"];
    
    if (range.length > 0) {
        NSUInteger loc = range.location + range.length;
        
        NSString *path = [url substringFromIndex:loc];
        
        //获得方法名
        NSArray *methodParam = [path componentsSeparatedByString:@"&"];
        
        //方法名
        NSString *methodName = [methodParam firstObject];
        //参数
        NSString *param =  nil;
        if (methodParam.count > 1) {
            param = [methodParam lastObject];
        }
        
        // clang 是负责编译 OC 程序的
        // 让 clang 编译到这一行的时候压栈
        
#pragma clang diagnostic push  // 让 clang 忽略 -Warc-performSelector-leaks 警告信息
        
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        SEL methodSel = NSSelectorFromString(methodName);
        
         // 判断方法的目的 : 防止因为方法不存在而报错
        if ([self respondsToSelector:methodSel]) {
             [self performSelector:methodSel withObject:param];
        }
       
        // 让 clang 出栈
#pragma clang diagnostic pop
        return NO;
    }
    return YES;
}

//set方法
- (void)setHeadLine:(TSZHeadline *)headLine{
    _headLine = headLine;
}

@end
