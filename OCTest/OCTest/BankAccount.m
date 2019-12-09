//
//  BankAccount.m
//  OCTest
//
//  Created by Jun Zhou on 2019/12/9.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import "BankAccount.h"
#import <YYModel.h>

@interface BankAccount ()

@property (nonatomic, strong) NSArray *transactionsDataList;

@end


@implementation BankAccount

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.currentBalance = @(10000);
        self.transactions = [NSArray yy_modelArrayWithClass:Transaction.class json:self.transactionsDataList].mutableCopy;
    }
    return self;
}

- (NSArray *)transactionsDataList {
    if (!_transactionsDataList) {
        _transactionsDataList = @[
            @{ @"payee" : @"Green Power", @"amount" : @(120.00), @"date": @"2015-12-01"},
            @{ @"payee" : @"Green Power", @"amount" : @(150.00), @"date": @"2016-01-01"},
            @{ @"payee" : @"Green Power", @"amount" : @(170.00), @"date": @"2016-02-01"},
            @{ @"payee" : @"Car Loan", @"amount" : @(250.00), @"date": @"2016-01-15"},
            @{ @"payee" : @"Car Loan", @"amount" : @(250.00), @"date": @"2016-02-15"},
            @{ @"payee" : @"Car Loan", @"amount" : @(250.00), @"date": @"2016-03-15"},
            @{ @"payee" : @"General Cable", @"amount" : @(120.00), @"date": @"2015-12-01"},
            @{ @"payee" : @"General Cable", @"amount" : @(155.00), @"date": @"2016-01-01"},
            @{ @"payee" : @"General Cable", @"amount" : @(120.00), @"date": @"2016-020-1"},
            @{ @"payee" : @"Mortgage", @"amount" : @(1250.00), @"date": @"2016-01-15"},
            @{ @"payee" : @"Mortgage", @"amount" : @(1250.00), @"date": @"2016-02-15"},
            @{ @"payee" : @"Mortgage", @"amount" : @(1250.00), @"date": @"2016-03-15"},
            @{ @"payee" : @"Animal Hospital", @"amount" : @(600.00), @"date": @"2016-01-15"},
        
        ];
    }
    return _transactionsDataList;
}

// MARK: - countOf<Key>

- (NSUInteger)countOfTransactions {
    return [self.transactions count];
}

// MARK: - objectIn<Key>AtIndex: or <key>AtIndexes:

- (id)objectInTransactionsAtIndex:(NSUInteger)index {
    return [self.transactions objectAtIndex:index];
}
 
- (NSArray *)transactionsAtIndexes:(NSIndexSet *)indexes {
    return [self.transactions objectsAtIndexes:indexes];
}

// MARK: - get<Key>:range:

- (void)getTransactions:(Transaction * __unsafe_unretained *)buffer
               range:(NSRange)inRange {
    [self.transactions getObjects:buffer range:inRange];
}

// MARK: - insertObject:in<Key>AtIndex: or insert<Key>:atIndexes:

- (void)insertObject:(Transaction *)transaction
  inTransactionsAtIndex:(NSUInteger)index {
    [self.transactions insertObject:transaction atIndex:index];
}
 
- (void)insertTransactions:(NSArray *)transactionArray
              atIndexes:(NSIndexSet *)indexes {
    [self.transactions insertObjects:transactionArray atIndexes:indexes];
}

// MARK: - removeObjectFrom<Key>AtIndex: or remove<Key>AtIndexes:

- (void)removeObjectFromTransactionsAtIndex:(NSUInteger)index {
    [self.transactions removeObjectAtIndex:index];
}
 
- (void)removeTransactionsAtIndexes:(NSIndexSet *)indexes {
    [self.transactions removeObjectsAtIndexes:indexes];
}

// MARK: - enumeratorOf<Key>

- (NSEnumerator *)enumeratorOfTransactions {
    return [self.transactions objectEnumerator];
}

- (void)setNilValueForKey:(NSString *)key {
    if ([key isEqualToString:@"currentBalance"]) {
        [self setValue:@(0) forKey:@"currentBalance"];
    } else {
        [super setNilValueForKey:key];
    }
}

- (BOOL)validateName:(id *)ioValue error:(NSError * __autoreleasing *)outError {
    if ((*ioValue == nil) || ([(NSString *)*ioValue length] < 2)) {
        if (outError != NULL) {
            *outError = [NSError errorWithDomain:@"BankAccount.name"
                                            code:1001
                                        userInfo:@{ NSLocalizedDescriptionKey
                                                    : @"Name too short" }];
        }
        return NO;
    }
    return YES;
}

- (BOOL)validateAge:(id *)ioValue error:(NSError * __autoreleasing *)outError {
    if (*ioValue == nil) {
        // Value is nil: Might also handle in setNilValueForKey
        *ioValue = @(0);
    } else if ([*ioValue floatValue] < 0.0) {
        if (outError != NULL) {
            *outError = [NSError errorWithDomain:@"BankAccount.name"
                                            code:1002
                                        userInfo:@{ NSLocalizedDescriptionKey
                                                    : @"Age cannot be negative" }];
        }
        return NO;
    }
    return YES;
}

- (id)valueForUndefinedKey:(NSString *)key {
    NSLog(@"valueForUndefinedKey: %@", key);
    return [super valueForUndefinedKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"setValue:forUndefinedKey: %@", key);
    [super setValue:value forUndefinedKey:key];
}

@end
