//
//  TSZNewsDetailViewController.h
//  NewsFromHTML
//
//  Created by Tsz on 15/11/17.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import <UIKit/UIKit.h>
//详情

@class TSZHeadline;
@class TSZNewsDetail;
@interface TSZNewsDetailViewController : UIViewController

//传入一个模型
@property (nonatomic ,strong) TSZHeadline *headLine;

@property (strong , nonatomic)TSZNewsDetail *detail;
@end
