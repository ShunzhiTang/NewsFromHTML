//
//  TSZStatusBarHUD.m
//  NewsFromHTML
//
//  Created by Tsz on 15/11/19.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import "TSZStatusBarHUD.h"

@implementation TSZStatusBarHUD

UIWindow *_window;
// 窗口的高度
#define TSZWindowHeight 20
// 动画的执行时间
#define TSZDuration 0.5
// 窗口的停留时间
#define TSZDelay 1.5
// 字体大小
#define TSZFont [UIFont systemFontOfSize:12]

/**
 *  显示信息
 *
 *  @param msg   文字内容
 *  @param image 图片对象
 */
+ (void)showMessage:(NSString *)msg image:(UIImage *)image
{
    
    if (_window) return;
    
    // 创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 设置按钮文字大小
    btn.titleLabel.font = TSZFont;
    
    // 切掉文字左边的 10
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    // 设置数据
    [btn setTitle:msg forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];\
    
    // 创建窗口
    _window = [[UIWindow alloc] init];
    // 窗口背景
    _window.backgroundColor = [UIColor blackColor];
    _window.windowLevel = UIWindowLevelAlert;
    _window.frame = CGRectMake(0, -TSZWindowHeight, [UIScreen mainScreen].bounds.size.width, TSZWindowHeight);
    btn.frame = _window.bounds;
    [_window addSubview:btn];
    _window.hidden = NO;
    
    // 状态栏 也是一个window ,状态栏的级别是 UIWindowLevelStatusBar
    // UIWindowLevelAlert > UIWindowLevelStatusBar > UIWindowLevelNormal
    
    // 动画
    [UIView animateWithDuration:TSZDuration animations:^{
        CGRect frame = _window.frame;
        frame.origin.y = 0;
        _window.frame = frame;
    }completion:^(BOOL finished) {
        
        [UIView animateWithDuration:TSZDuration delay:TSZDelay options:kNilOptions animations:^{
            CGRect frame = _window.frame;
            frame.origin.y = -TSZWindowHeight;
            _window.frame = frame;
        } completion:^(BOOL finished) {
            _window = nil;
        }];
    }];
}

/**
 *  显示信息
 *
 *  @param msg       文字内容
 *  @param imageName 图片名称
 */
+ (void)showMessage:(NSString *)msg imageName:(NSString *)imageName
{
    [self showMessage:msg image:[UIImage imageNamed:imageName]];
}

/**
 *  显示成功信息
 *
 *  @param msg 文字信息
 */
+ (void)showSuccess:(NSString *)msg
{
    [self showMessage:msg imageName:@"TSZStatusBarHUD.bundle/success.png"];
}


/**
 *  显示失败信息
 *
 *  @param msg 文字信息
 */
///Users/tang/Desktop/iOS代码/HTML和OC的结合/oc和js实现新闻预览/NewsFromHTML/NewsFromHTML/NewsFromHTML/Lib/TSZStatusBarHUD/HMStatusBarHUD.bundle/success@2x.png
+ (void)showError:(NSString *)msg
{
    [self showMessage:msg imageName:@"/TSZStatusBarHUD.bundle/error.png"];
    
}

/**
 *  隐藏窗口
 */
+ (void)hideLoading
{
    // 动画
    [UIView animateWithDuration:TSZDuration animations:^{
        CGRect frame = _window.frame;
        frame.origin.y = -TSZWindowHeight;
        _window.frame = frame;
    }completion:^(BOOL finished) {
        _window = nil;
    }];
}

/**
 *  加载
 *
 *  @param msg 文字信息
 */
+ (void)showLoading:(NSString *)msg
{
    
    if (_window) return;
    
    // 创建窗口
    _window = [[UIWindow alloc] init];
    // 窗口背景
    _window.backgroundColor = [UIColor blackColor];
    _window.windowLevel = UIWindowLevelAlert;
    _window.frame = CGRectMake(0, -TSZWindowHeight, [UIScreen mainScreen].bounds.size.width, TSZWindowHeight);
    _window.hidden = NO;
    
    // 文字
    UILabel *label = [[UILabel alloc] init];
    label.frame = _window.bounds;
    label.font = TSZFont;
    label.text = msg;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [_window addSubview:label];
    
    // 圈圈 , 程序自带的那个指示器
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [indicatorView startAnimating];
    indicatorView.frame = CGRectMake(0, 0, TSZWindowHeight, TSZWindowHeight);
    [_window addSubview:indicatorView];
    
    // 动画
    [UIView animateWithDuration:TSZDuration animations:^{
        CGRect frame = _window.frame;
        frame.origin.y = 0;
        _window.frame = frame;
    }];
    
}
@end
