//
//  TSZNewsDetailViewController.m
//  NewsFromHTML
//
//  Created by Tsz on 15/11/17.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import "TSZNewsDetailViewController.h"
#import "TSZHeadline.h"
#import "TSZHTTPManager.h"

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
    [[TSZHTTPManager manager] GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
         [responseObject writeToFile:@"/Users/tang/Desktop/newsDetail.plist" atomically:YES];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@" ,error);
    }];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.headLine.url_3w]];

    [self.webView loadRequest:request];

}

//set方法
- (void)setHeadLine:(TSZHeadline *)headLine{
    _headLine = headLine;
}

@end
