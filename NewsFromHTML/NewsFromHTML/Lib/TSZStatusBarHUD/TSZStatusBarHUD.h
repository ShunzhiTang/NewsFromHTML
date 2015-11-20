//
//  TSZStatusBarHUD.h
//  NewsFromHTML
//  Created by Tsz on 15/11/19.
//  Copyright © 2015年 Tsz. All rights reserved.

#import <UIKit/UIKit.h>


@interface TSZStatusBarHUD : NSObject
/**
 *  显示信息 (此方法已过期,建议使用XXXX方法 )
 *
 *  @param msg   文字内容
 *  @param image 图片对象
 */
+ (void)showMessage:(NSString *)msg image:(UIImage *)image;
/**
 *  显示信息
 *
 *  @param msg       文字内容
 *  @param imageName 图片名称 (图片高度最好在 20 以内, 仅限于本地图片)
 */
+ (void)showMessage:(NSString *)msg imageName:(NSString *)imageName;
/**
 *  显示成功信息
 *
 *  @param msg 文字信息
 */
+ (void)showSuccess:(NSString *)msg;  //NS_DEPRECATED_IOS(2_0, 3_0, "请使用xxxx方法!!!");

/**
 *  显示失败信息
 *
 *  @param msg 文字信息
 */
+ (void)showError:(NSString *)msg;

/**
 *  可以实现加载
 *
 *  @param msg 文字信息
 */
+ (void)showLoading:(NSString *)msg;
/**
 *  隐藏窗口
 */
+ (void)hideLoading;


@end
