//
//  CustomViewController.m
//  CustomAlertView
//
//  Created by likai on 16/8/16.
//  Copyright © 2016年 kkk. All rights reserved.
//

#import "CustomViewController.h"
#import "PopupAnimation.h"
#import <PureLayout/PureLayout.h>
#import "CustomViewCell.h"

@interface CustomViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *bgWhiteView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) PopupAnimation *animation;

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self addSubViews];
    
    [self.animation addPopupAnimationToView:self.bgWhiteView
                                     bgView:self.bgView
                        bgViewOriginOpacity:0.0
                         bgViewFinalOpacity:0.6
                                 duringTime:0.5
                            completionBlock:^{}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellID = @"serviceProcotolCell";
    CustomViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    if(!cell) {
        cell = [[CustomViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"Item index0";
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"Item index1";
    } else if (indexPath.row == 2) {
        cell.titleLabel.text = @"Item index2";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(customAlertViewCallBack:)]) {
        [self.delegate customAlertViewCallBack:self];
    }
}

#pragma mark - Event Response

#pragma mark - Custom Methods

- (void)showInView:(UIView *)superView {
    
    [superView.window addSubview:self.view];
    
}

//取消
- (void)cancelAction {
    __block CustomViewController *bSelf = self;
    [self.animation addHideAnimationToView:self.bgWhiteView
                                    bgView:self.bgView
                       bgViewOriginOpacity:0.6
                        bgViewFinalOpacity:0.0
                                duringTime:0.2
                           completionBlock:^{
                               if (bSelf.delegate &&
                                   [bSelf.delegate respondsToSelector:@selector(customAlertViewCallBack:)]) {
                                   [bSelf.delegate customAlertViewCallBack:bSelf];
                               }
                           }];
}

- (void)addSubViews {
    
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.bgWhiteView];
    [self.bgWhiteView addSubview:self.cancelBtn];
    [self.bgWhiteView addSubview:self.tableView];
    
    [self setContraint];
}

- (void)setContraint {
    
    [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0];
    [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0];
    [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0];
    [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0];

    [self.bgWhiteView autoCenterInSuperview];
    [self.bgWhiteView autoSetDimensionsToSize:CGSizeMake(280.f, 44.0*3.0 + 44.0)];

    [self.cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0];
    [self.cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0];
    [self.cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0];
    [self.cancelBtn autoSetDimension:ALDimensionHeight toSize:44.0];
    
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0];
    [self.tableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.cancelBtn];
}

#pragma mark - Getters and Setters

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.0;
    }
    return _bgView;
}

- (UIView *)bgWhiteView {
    if (!_bgWhiteView) {
        _bgWhiteView = [UIView newAutoLayoutView];
        _bgWhiteView.backgroundColor = [UIColor whiteColor];
        _bgWhiteView.layer.masksToBounds = YES;
        _bgWhiteView.userInteractionEnabled = YES;
        _bgWhiteView.layer.cornerRadius = 5.f;
    }
    return _bgWhiteView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton newAutoLayoutView];
        [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17.f];
        [_cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    }
    return _cancelBtn;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView newAutoLayoutView];
        [_tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
        _tableView.scrollEnabled = NO;
        _tableView.userInteractionEnabled = YES;
        _tableView.delegate =(id<UITableViewDelegate>)self;
        _tableView.dataSource = (id<UITableViewDataSource>)self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.backgroundView = nil;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (PopupAnimation *)animation {
    if (!_animation) {
        _animation = [[PopupAnimation alloc] init];
    }
    return _animation;
}

@end