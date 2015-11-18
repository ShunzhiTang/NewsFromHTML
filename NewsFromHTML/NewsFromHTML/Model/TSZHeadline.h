//
//  TSZHeadline.h
//  NewsFromHTML
//
//  Created by Tsz on 15/11/17.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSZHeadline : NSObject

/** 新闻标题*/
/** 新闻标题 */
@property (nonatomic , copy) NSString *title;
/** 新闻摘要 */
@property (nonatomic , copy) NSString *digest;
/** 图片 */
@property (nonatomic , copy) NSString *imgsrc;

@property (nonatomic , copy) NSString *url;
/** 新闻url */
@property (nonatomic , copy) NSString *url_3w;
/** 新闻id */
@property (nonatomic , copy) NSString *docid;

+ (instancetype)headlineWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
