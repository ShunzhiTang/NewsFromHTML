//
//  TSZNewsDetailImage.h
//  NewsFromHTML
//
//  Created by Tsz on 15/11/17.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSZNewsDetailImage : NSObject
/** 图片路径 */
@property (nonatomic, copy) NSString *src;
/** 图片尺寸 */
@property (nonatomic, copy) NSString *pixel;
/** 图片所处的位置 */
@property (nonatomic, copy) NSString *ref;
+ (instancetype)detailImgWithDict:(NSDictionary *)dict;

@end
