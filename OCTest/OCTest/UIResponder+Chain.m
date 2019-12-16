//
//  UIResponder+Chain.m
//  OCTest
//
//  Created by Jun Zhou on 2019/12/16.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import "UIResponder+Chain.h"

@implementation UIResponder (Chain)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
