//
//  TSZNewsDetailViewController.h
//  NewsFromHTML
//
//  Created by Tsz on 15/11/17.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSZHeadline;
@interface TSZNewsDetailViewController : UIViewController

//传入一个模型
@property (nonatomic ,strong) TSZHeadline *headLine;

@end
