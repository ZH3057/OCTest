//
//  EOCAutoDictionary.h
//  OCTest
//
//  Created by Jun Zhou on 2019/11/30.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EOCAutoDictionary : NSObject

@property (copy, nonatomic) NSString *string;

@property (strong, nonatomic) NSNumber *number;

@property (strong, nonatomic) NSDate *date;

@property (strong, nonatomic) id opaqueObject;

@end

NS_ASSUME_NONNULL_END
