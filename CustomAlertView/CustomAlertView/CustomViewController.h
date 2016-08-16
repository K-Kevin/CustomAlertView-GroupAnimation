//
//  CustomViewController.h
//  CustomAlertView
//
//  Created by likai on 16/8/16.
//  Copyright © 2016年 kkk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomAlertViewDelegate  <NSObject>

- (void)customAlertViewCallBack:(UIViewController *)vc;

@end


@interface CustomViewController : UIViewController

@property (nonatomic, weak) id<CustomAlertViewDelegate> delegate;

- (void)showInView:(UIView *)superView;

@end
