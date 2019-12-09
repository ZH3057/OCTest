//
//  Transaction.h
//  OCTest
//
//  Created by Jun Zhou on 2019/12/9.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Transaction : NSObject

@property (nonatomic, copy)   NSString* payee;   // To whom
@property (nonatomic, strong) NSNumber* amount;  // How much
@property (nonatomic, strong) NSDate*   date;    // When

@end

NS_ASSUME_NONNULL_END
