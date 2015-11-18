//
//  TSZHeadline.m
//  NewsFromHTML
//
//  Created by Tsz on 15/11/17.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import "TSZHeadline.h"

@implementation TSZHeadline

+ (instancetype)headlineWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
//        self.title = dict[@"title"];
//        self.digest = dict[@"digest"];
//        self.imgsrc = dict[@"imgsrc"];
        
        // KVC (key value coding)键值编码
        // cocoa 的大招，允许间接修改对象的属性值
        // 第一个参数是字典的数值
        // 第二个参数是类的属性
        
        [self setValue:dict[@"title"] forKey:@"title"];
        [self setValue:dict[@"digest"] forKey:@"digest"];
        [self setValue:dict[@"imgsrc"] forKey:@"imgsrc"];
    }
    return self;
}
@end
