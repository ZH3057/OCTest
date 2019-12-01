//
//  NSObject+MsgForwarding.m
//  OCTest
//
//  Created by Jun Zhou on 2019/11/30.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import "NSObject+MsgForwarding.h"
#import <objc/runtime.h>

@implementation NSObject (MsgForwarding)

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
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"target: %@, selector: %@", anInvocation.target, NSStringFromSelector(anInvocation.selector));
}

+ (void)doesNotRecognizeSelector:(SEL)aSelector {
    
}

@end
