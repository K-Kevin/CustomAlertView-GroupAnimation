//
//  CAAnimationGroup+Blocks.m
//
//
//  Created by likai on 16/3/31.
//  Copyright © 2016年 kkk. All rights reserved.
//

#import "CAAnimationGroup+Blocks.h"
#import <objc/runtime.h>

static char CAAnimationGroupBlockKey;

@implementation CAAnimationGroup (Blocks)

- (void)setCompletionBlock:(AnimationGroupCompletionBlock)handler {
    objc_setAssociatedObject(self, &CAAnimationGroupBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    self.delegate = self;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        AnimationGroupCompletionBlock handler = (AnimationGroupCompletionBlock)objc_getAssociatedObject(self, &CAAnimationGroupBlockKey);
        if (handler) {
            handler();
        }
    }
}

@end
