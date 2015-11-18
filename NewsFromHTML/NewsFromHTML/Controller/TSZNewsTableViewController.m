//  ViewController.m
//  NewsFromHTML

//  Created by Tsz on 15/11/16.
//  Copyright © 2015年 Tsz. All rights reserved.

#import "TSZNewsTableViewController.h"
#import "TSZHTTPManager.h"
#import "TSZHeadline.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "TSZNewsDetailViewController.h"

@interface TSZNewsTableViewController ()

@property (nonatomic , strong)NSArray *newsArray;

@end

@implementation TSZNewsTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    self.title = @"头条新闻";
    
    [self getNewsContents];
    
    self.tableView.rowHeight = 80;
    
}

#pragma mark: 获取数据资源
- (void)getNewsContents{

    TSZHTTPManager *manager = [TSZHTTPManager manager];
    
    //配置iOS7旧系统
    [manager GET:@"http://c.m.163.com/nc/article/headline/T1348647853363/0-140.html" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        //获取新闻字典
        NSArray *dictArray = responseObject[@"T1348647853363"];
        
        _newsArray = [TSZHeadline objectArrayWithKeyValuesArray:dictArray];
        
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark: 实现TableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1、获取cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    
    TSZHeadline *headline = self.newsArray[indexPath.row];
    
    cell.textLabel.text = headline.title;
    cell.detailTextLabel.text = headline.digest;
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:headline.imgsrc]placeholderImage:[UIImage imageNamed:@"loading"]];
     
    return cell;
}

#pragma mark: 点击cell传入跳转
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //赋值
    TSZNewsDetailViewController *detailVc =[[TSZNewsDetailViewController alloc] init] ;
//    detailVc.headLine = self.newsArray[0];
    [self presentViewController:detailVc animated:YES completion:nil];
}

// 准备跳转界面
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSUInteger row = self.tableView.indexPathForSelectedRow.row;
    TSZNewsDetailViewController *detailVc = segue.destinationViewController;
    detailVc.headLine = self.newsArray[row];
}

@end
