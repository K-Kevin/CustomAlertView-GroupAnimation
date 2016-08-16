//
//  RootViewController.m
//  CustomAlertView
//
//  Created by likai on 16/8/16.
//  Copyright © 2016年 kkk. All rights reserved.
//

#import "RootViewController.h"
#import <PureLayout/PureLayout.h>
#import "CustomViewController.h"

@interface RootViewController ()<CustomAlertViewDelegate>

@property (nonatomic, strong) CustomViewController *alertView;

@property (nonatomic, strong) UIButton *button;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.button];
    
    [self.button autoCenterInSuperview];
    [self.button autoSetDimensionsToSize:CGSizeMake(200.0, 45.0)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertAction {
    [self.alertView showInView:self.view];
}

#pragma mark - Delegate

- (void)customAlertViewCallBack:(UIViewController *)vc {
    if ([self.alertView isEqual:vc]) {
        [self.alertView.view removeFromSuperview];
        self.alertView.delegate = nil;
        self.alertView = nil;
    }
}

- (CustomViewController *)alertView {
    if (!_alertView) {
        _alertView = [[CustomViewController alloc] init];
        _alertView.delegate = self;
    }
    return _alertView;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton newAutoLayoutView];
        [_button setTitle:@"alert" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_button setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [_button addTarget:self action:@selector(alertAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end
