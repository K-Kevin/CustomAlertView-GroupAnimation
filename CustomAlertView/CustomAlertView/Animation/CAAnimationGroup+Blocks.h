//
//  CAAnimationGroup+Blocks.h
//  
//
//  Created by likai on 16/3/31.
//  Copyright © 2016年 kkk. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

/**
 *  CAAnimationGroup didStop completionBlock
 *   @2016年03月31日09:18:40
 */

typedef void (^AnimationGroupCompletionBlock)();

@interface CAAnimationGroup (Blocks)

- (void)setCompletionBlock:(AnimationGroupCompletionBlock)handler;

@end
