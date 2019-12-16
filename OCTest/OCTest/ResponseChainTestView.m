//
//  ResponseChainTestView.m
//  OCTest
//
//  Created by Jun Zhou on 2019/12/16.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import "ResponseChainTestView.h"
#import <Masonry.h>
#import "UIResponder+Chain.h"

@interface ResponseChainTestView ()

@property (nonatomic, strong) UIButton *testButton;

@end


@implementation ResponseChainTestView

// MARK: - Init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
        [self setupSubviews];
    }
    return self;
}


// MARK: - Config UI

- (void)configUI {
    self.testButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.testButton.backgroundColor = UIColor.redColor;
    [self.testButton addTarget:self action:@selector(testButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.testButton];
}

// MARK: - Setup Subviews

- (void)setupSubviews {
    
}

// MARK: - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.testButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(self).dividedBy(2);
        make.height.equalTo(self).dividedBy(2);
    }];
}

// MARK: - Action

- (void)testButtonClick {
    [self routerEventWithName:@"testButtonClick" userInfo:@{}];
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    NSLog(@"ResponseChainTestView eventName: %@", eventName);
    [super routerEventWithName:eventName userInfo:userInfo];
}

// MARK: - Data Fill

// MARK: - Privite

// MARK: - Getter

@end
