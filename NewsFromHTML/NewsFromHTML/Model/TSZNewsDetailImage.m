//  TSZNewsDetailImage.m
//  NewsFromHTML
//
//  Created by Tsz on 15/11/17.
//  Copyright © 2015年 Tsz. All rights reserved.

#import "TSZNewsDetailImage.h"

@implementation TSZNewsDetailImage
// 实现
+ (instancetype)detailImgWithDict:(NSDictionary *)dict
{
    TSZNewsDetailImage *img = [[self alloc] init];
    img.pixel = dict[@"pixel"];
    img.src = dict[@"src"];
    img.ref = dict[@"ref"];
    return img;
}
@end
