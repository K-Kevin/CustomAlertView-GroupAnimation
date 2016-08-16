//
//  PopupAnimation.h
//  
//
//  Created by likai on 16/3/31.
//  Copyright © 2016年 kkk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void (^AnimationCompletionBlock)();

/**
 模拟视图弹出动画
 *
 *  @2016年03月31日09:18:40
 *  目前禁用了动画期间的操作
 */

@interface PopupAnimation : NSObject

/**
 给视图添加弹出效果
 
 @param popupView.
 @param bgView. bgView 在传入前不必设置透明度，只需设置背景色即可
 @param bgOriginOpacity. 背景图层动画初始透明度，推荐 0
 @param bgFinalOpacity. 背景图层动画结束透明度，推荐 0.6
 @param timeInterval. 推荐使用 0.5

 @return
 */
- (void)addPopupAnimationToView:(UIView *)popupView
                          bgView:(UIView *)bgView
            bgViewOriginOpacity:(float)bgOriginOpacity
             bgViewFinalOpacity:(float)bgFinalOpacity
                      duringTime:(CFTimeInterval)timeInterval
                 completionBlock:(AnimationCompletionBlock)handler;

/**
 给弹出的视图添加隐藏效果
 
 @param popupView
 @param bgView. bgView 在传入前不必设置透明度，只需设置背景色即可
 @param bgOriginOpacity. 背景图层动画初始透明度，与 popup 动画的 bgFinalOpacity 值相同，即 0.6
 @param bgFinalOpacity. 背景图层动画结束透明度，与 popup 动画的 bgFinalOpacity 值相同，即 0
 @param timeInterval. 推荐使用 0.2
 
 @return
 */
- (void)addHideAnimationToView:(UIView *)popupView
                         bgView:(UIView *)bgView
           bgViewOriginOpacity:(float)bgOriginOpacity
            bgViewFinalOpacity:(float)bgFinalOpacity
                     duringTime:(CFTimeInterval)timeInterval
                completionBlock:(AnimationCompletionBlock)handler;

@end
