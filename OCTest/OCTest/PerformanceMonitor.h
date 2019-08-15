//
//  PerformanceMonitor.h
//  OCTest
//
//  Created by Jun Zhou on 2019/4/16.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PerformanceMonitor : NSObject

+ (void)addmainRunloopObserver;
+ (void)addOtherObserver;

@end

NS_ASSUME_NONNULL_END
