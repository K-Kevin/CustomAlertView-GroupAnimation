//
//  CustomViewCell.m
//  CustomAlertView
//
//  Created by likai on 16/8/16.
//  Copyright © 2016年 kkk. All rights reserved.
//

#import "CustomViewCell.h"
#import <PureLayout/PureLayout.h>

#define HEXCOLOR(rgbValue)             [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface CustomViewCell()

@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation CustomViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addSubViews {
    
    [self.contentView addSubview:self.bottomLine];
    [self.contentView addSubview:self.titleLabel];
    
    [self setContraint];
}

- (void)setContraint {
    
    [self.bottomLine autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0];
    [self.bottomLine autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0];
    [self.bottomLine autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0];
    [self.bottomLine autoSetDimension:ALDimensionHeight toSize:0.5];
    
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0];
    [self.titleLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.bottomLine];

}

#pragma mark - Getters and Setters

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView newAutoLayoutView];
        _bottomLine.backgroundColor = HEXCOLOR(0xe5e5e5);
    }
    return _bottomLine;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel newAutoLayoutView];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        _titleLabel.font = [UIFont systemFontOfSize:15.f];
    }
    return _titleLabel;
}

@end
