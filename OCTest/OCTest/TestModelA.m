//
//  TestModelA.m
//  OCTest
//
//  Created by Jun Zhou on 2019/4/15.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import "TestModelA.h"

@implementation TestModelA

- (void)test {
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"TestModelA instance init");
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

+ (NSMethodSignature *)instanceMethodSignatureForSelector:(SEL)aSelector {
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"target: %@, selector: %@", anInvocation.target, NSStringFromSelector(anInvocation.selector));
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    
}



+ (BOOL)resolveClassMethod:(SEL)sel {
    return NO;
}

+ (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    //return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    return nil;
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"target: %@, selector: %@", anInvocation.target, NSStringFromSelector(anInvocation.selector));
}

+ (void)doesNotRecognizeSelector:(SEL)aSelector {
    
}

@end
