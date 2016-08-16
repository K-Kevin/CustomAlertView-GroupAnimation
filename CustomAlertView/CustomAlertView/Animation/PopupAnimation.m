//
//  PopupAnimation.m
//
//
//  Created by likai on 16/3/31.
//  Copyright © 2016年 kkk. All rights reserved.
//

#import "PopupAnimation.h"
#import "CAAnimationGroup+Blocks.h"

@implementation PopupAnimation

- (void)addPopupAnimationToView:(UIView *)popupView
                         bgView:(UIView *)bgView
            bgViewOriginOpacity:(float)bgOriginOpacity
             bgViewFinalOpacity:(float)bgFinalOpacity
                     duringTime:(CFTimeInterval)timeInterval
                completionBlock:(AnimationCompletionBlock)handler {
    
    __block BOOL flag = popupView.userInteractionEnabled;
    
    popupView.userInteractionEnabled = NO;
    
    bgView.layer.opacity = bgFinalOpacity;
    //opacity animation
    CAKeyframeAnimation *bOpacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    bOpacity.values = @[@(bgOriginOpacity),@(bgFinalOpacity),@(bgFinalOpacity)];
    bOpacity.keyTimes = @[@0.0f, @0.3f, @1.0f];
    bOpacity.duration = timeInterval;
    [bgView.layer addAnimation:bOpacity forKey:nil];
    
    //transform animation
    CAKeyframeAnimation *trans = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    NSArray *transValues = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    trans.values = transValues;
    NSArray *times = @[@0.0f, @0.5f, @0.75f, @1.0f];
    trans.keyTimes = times;
    trans.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                              [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                              [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    //opacity animation
    CAKeyframeAnimation *opacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    NSArray *opValues = @[@(0.0),@(0.6),@(1.0),@(1.0)];
    opacity.values = opValues;
    opacity.keyTimes = times;
    
    //group animations
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[trans, opacity];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.duration = timeInterval;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.beginTime = CACurrentMediaTime();
    
    [group setCompletionBlock:^{
        
        popupView.userInteractionEnabled = flag;
        
        if (handler) {
            handler();
        }
    }];
    
    [popupView.layer addAnimation:group forKey:@"show"];
}

- (void)addHideAnimationToView:(UIView *)popupView
                        bgView:(UIView *)bgView
           bgViewOriginOpacity:(float)bgOriginOpacity
            bgViewFinalOpacity:(float)bgFinalOpacity
                    duringTime:(CFTimeInterval)timeInterval
               completionBlock:(AnimationCompletionBlock)handler {
    
    __block BOOL flag = popupView.userInteractionEnabled;

    popupView.userInteractionEnabled = NO;
    
    bgView.layer.opacity = bgFinalOpacity;
    
    //opacity animation
    CAKeyframeAnimation *bOpacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    bOpacity.values = @[@(bgOriginOpacity),@(bgOriginOpacity/2.0),@(bgFinalOpacity)];
    bOpacity.keyTimes = @[@0.0f, @0.5f, @1.0f];
    bOpacity.duration = timeInterval;
    [bgView.layer addAnimation:bOpacity forKey:nil];
    
    //transform animation
    CAKeyframeAnimation *trans = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    NSArray *transValues = @[[NSValue valueWithCATransform3D:CATransform3DIdentity],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0f, 0.0f, 1.0f)]];
    trans.values = transValues;
    NSArray *times = @[@0.0f, @1.0f];
    trans.keyTimes = times;
    
    //opacity animation
    CAKeyframeAnimation *opacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    NSArray *opValues = @[@(1.0),@(0.0)];
    opacity.values = opValues;
    opacity.keyTimes = times;
    
    //group animations
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[trans, opacity];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.duration = timeInterval;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.beginTime = CACurrentMediaTime();
    
    [group setCompletionBlock:^{
        
        popupView.userInteractionEnabled = flag;
        
        if (handler) {
            handler();
        }
    }];
    
    [popupView.layer addAnimation:group forKey:@"hide"];
}

@end
