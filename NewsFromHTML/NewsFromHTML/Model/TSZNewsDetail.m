//
//  TSZNewsDetail.m
//  NewsFromHTML
//
//  Created by Tsz on 15/11/17.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import "TSZNewsDetail.h"
#import "TSZNewsDetailImage.h"

@implementation TSZNewsDetail
+ (instancetype)detailWithDict:(NSDictionary *)dict
{
    TSZNewsDetail *detail = [[self alloc] init];
    detail.title = dict[@"title"];
    detail.ptime = dict[@"ptime"];
    detail.body = dict[@"body"];
    
    // 图片字典数组
    NSArray *imgDictArray = dict[@"img"];
    // 图片模型数组
    NSMutableArray *imgModelArray = [NSMutableArray array];
    for (NSDictionary *imgDict in imgDictArray) {
        TSZNewsDetailImage *imgModel = [TSZNewsDetailImage detailImgWithDict:imgDict];
        [imgModelArray addObject:imgModel];
    }
    detail.img = imgModelArray;
    
    return detail;
}
@end
