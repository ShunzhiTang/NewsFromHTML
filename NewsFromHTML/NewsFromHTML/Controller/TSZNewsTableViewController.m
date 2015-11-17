//
//  ViewController.m
//  NewsFromHTML
//
//  Created by Tsz on 15/11/16.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import "TSZNewsTableViewController.h"
//#import "AFHTTPSessionManager.h"
#import "AFNetworking.h"
@interface TSZNewsTableViewController ()

@end

@implementation TSZNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   
    
    //配置iOS7旧系统
    [[AFHTTPRequestOperationManager manager] GET:@"http://c.m.163.com/nc/article/headline/T1348647853363/0-140.html" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@" , error);
    }];
    
}


#pragma mark: 实现TableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //1、获取cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    cell.textLabel.text = @"哈哈";
    
    cell.detailTextLabel.text = @"你好";
    return cell;
}

@end
