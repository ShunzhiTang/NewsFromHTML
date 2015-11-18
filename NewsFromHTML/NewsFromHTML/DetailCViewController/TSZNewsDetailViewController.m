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

#import "TSZNewsDetail.h"

@interface TSZNewsDetailViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;



@end
@implementation TSZNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 发送一个get请求,获得新闻的详情数据
    // 地址: http://c.m.163.com/nc/article/{docid}/full.html
    //一般做法
    
    self.title  = @"新闻详情";
    
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
    [body appendFormat:@"<div style=\"text-align: center;\"> %@</div>",self.detail.title];
    
    //拼接时间
    [body appendFormat:@"<div style = \"text-align: center;\">%@</div>" , self.detail.ptime];
    [body appendString:self.detail.body];
    
    for (TSZNewsDetailImage  *img in self.detail.img) {
        
        NSMutableString *imgHtml = [NSMutableString string];
        [imgHtml appendString:@"<div style=\"text-align: center;\">"];
        
        [imgHtml appendFormat:@"<img style=\"width:100px;height:100px;\"src=\"%@\">",img.src];
        [imgHtml appendString:@"</div>"];
        
        [body  replaceOccurrencesOfString:img.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;
}

//set方法
- (void)setHeadLine:(TSZHeadline *)headLine{
    _headLine = headLine;
}

@end
