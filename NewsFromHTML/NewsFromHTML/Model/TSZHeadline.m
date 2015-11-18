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
        self.title = dict[@"title"];
        self.digest = dict[@"digest"];
        self.imgsrc = dict[@"imgsrc"];
    }
    return self;
}
@end
