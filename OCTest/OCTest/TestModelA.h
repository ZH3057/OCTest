//
//  TestModelA.h
//  OCTest
//
//  Created by Jun Zhou on 2019/4/15.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestModelB.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestModelA : NSObject

@property (nonatomic, strong) TestModelB *modelB;

@end

NS_ASSUME_NONNULL_END
