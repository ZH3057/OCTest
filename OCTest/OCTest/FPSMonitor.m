//
//  FPSMonitor.m
//  OCTest
//
//  Created by Jun Zhou on 2019/4/16.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import "FPSMonitor.h"

static CADisplayLink *_link;
static int _count;
static NSTimeInterval _lastTime;
static FPSMonitor *_monitor;

@implementation FPSMonitor

+ (instancetype)shareMonitor {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _monitor = [[FPSMonitor alloc] init];
    });
    return _monitor;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _monitor = [super allocWithZone:zone];
    });
    return _monitor;
}

- (id)copyWithZone:(NSZone *)zone {
    return _monitor;
}

+ (void)start {
    _lastTime = _count = 0;
    _link = [CADisplayLink displayLinkWithTarget:[FPSMonitor shareMonitor] selector:@selector(clock)];
    [_link addToRunLoop:NSRunLoop.mainRunLoop forMode:NSRunLoopCommonModes];
}

- (void)clock {
    if (_lastTime == 0) {
        _lastTime = _link.timestamp;
        return;
    }
    
    _count += 1;
    NSTimeInterval delta = _link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = _link.timestamp;
    float fps = _count / delta;
    _count = 0;
    NSLog(@"fps: %f", fps);
}

@end
