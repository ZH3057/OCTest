//
//  BankAccount.h
//  OCTest
//
//  Created by Jun Zhou on 2019/12/9.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transaction.h"

NS_ASSUME_NONNULL_BEGIN

@interface BankAccount : NSObject

@property (nonatomic, strong) NSNumber* currentBalance;              // An attribute
@property (nonatomic, strong) NSMutableArray< Transaction* >* transactions; // A to-many relation

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

@end

NS_ASSUME_NONNULL_END
