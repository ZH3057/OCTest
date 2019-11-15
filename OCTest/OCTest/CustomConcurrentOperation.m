//
//  CustomConcurrentOperation.m
//  OCTest
//
//  Created by Jun Zhou on 2019/11/15.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import "CustomConcurrentOperation.h"

@interface CustomConcurrentOperation () {
    BOOL executing;
    BOOL finished;
}

@end


@implementation CustomConcurrentOperation

- (id)init {
    self = [super init];
    if (self) {
        executing = NO;
        finished = NO;
    }
    return self;

}

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isAsynchronous {
    return YES;
}

- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}

- (void)completeOperation {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    executing = NO;
    finished = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

- (void)start {
    // Always check for cancellation before launching the task.
    if (self.isCancelled) {
        // Must move the operation to the finished state if it is canceled.
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    // If the operation is not canceled, begin executing the task.
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)main {
    @try {
        // Do the main work of the operation here.
        // TODO:
        //...
        
        
        
        [self completeOperation];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

@end
