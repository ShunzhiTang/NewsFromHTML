//
//  TSZHTTPManager.m
//  NewsFromHTML
//
//  Created by Tsz on 15/11/17.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import "TSZHTTPManager.h"

@implementation TSZHTTPManager

+ (instancetype)manager{
    
    TSZHTTPManager *manger = [super manager];
    
    NSMutableSet *newSet = [NSMutableSet set];
    
    newSet.set = manger.responseSerializer.acceptableContentTypes;
    
    [newSet addObject:@"text/html"];
    
    manger.responseSerializer.acceptableContentTypes = newSet;
    return manger;
}
@end
