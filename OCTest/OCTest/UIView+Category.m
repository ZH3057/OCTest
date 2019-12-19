//
//  UIView+Category.m
//  OCTest
//
//  Created by Jun Zhou on 2019/12/19.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

/*
  寻找view1 和 view2的最近公共父视图步骤
  查询view1 是否在view2->superVuiew->superView->...nil这条链路上
  不在view1 = view.superView继续上述步骤
 */
- (UIView *)closestCommonSuperview:(UIView *)targetView {
    UIView *closestSuperview = nil;

    UIView *targetViewSuperview = targetView;
    while (!closestSuperview && targetViewSuperview) {
        UIView *selfViewSuperview = self;
        while (!closestSuperview && selfViewSuperview) {
            if (targetViewSuperview == selfViewSuperview) {
                closestSuperview = targetViewSuperview;
            }
            selfViewSuperview = selfViewSuperview.superview;
        }
        targetViewSuperview = selfViewSuperview.superview;
    }
    return closestSuperview;
}


@end
