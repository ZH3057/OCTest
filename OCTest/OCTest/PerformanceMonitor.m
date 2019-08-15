//
//  PerformanceMonitor.m
//  OCTest
//
//  Created by Jun Zhou on 2019/4/16.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import "PerformanceMonitor.h"

@interface PerformanceMonitor ()

@end

@implementation PerformanceMonitor

static CFRunLoopObserverRef _mainObserver;
static CFRunLoopObserverRef _otherObserver;
static PerformanceMonitor *_monitor;
static NSTimer *_timer1;
static NSTimer *_timer2;

+ (instancetype)shareMonitor {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _monitor = [[PerformanceMonitor alloc] init];
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

+ (void)addmainRunloopObserver {
    
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    _mainObserver = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                            kCFRunLoopAllActivities,
                                            YES,
                                            0,
                                            &mainRunLoopObserverCallBack,
                                            &context);
    
    CFRunLoopAddObserver(CFRunLoopGetMain(), _mainObserver, kCFRunLoopCommonModes);
    
//    _timer1 = [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"###cmm###timer时间到");
//    }];
}

static void mainRunLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    switch (activity) {
            
        case kCFRunLoopEntry:
            NSLog(@"###cmm###进入kCFRunLoopEntry");
            break;
            
        case kCFRunLoopBeforeTimers:
            NSLog(@"###cmm###即将处理Timer事件");
            break;
            
        case kCFRunLoopBeforeSources:
            NSLog(@"###cmm###即将处理Source事件");
            break;
            
        case kCFRunLoopBeforeWaiting:
            NSLog(@"###cmm###即将休眠");
            break;
            
        case kCFRunLoopAfterWaiting:
            NSLog(@"###cmm###被唤醒");
            break;
            
        case kCFRunLoopExit:
            NSLog(@"###cmm###退出RunLoop");
            break;
            
        default:
            break;
    }
}

- (void)dealloc {
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), _mainObserver, kCFRunLoopCommonModes);
    CFRelease(_mainObserver);
    _mainObserver = NULL;
    [_timer1 invalidate];
    _timer1 = nil;
    
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), _otherObserver, kCFRunLoopCommonModes);
    CFRelease(_otherObserver);
    _otherObserver = NULL;
    [_timer2 invalidate];
    _timer2 = nil;
}




+ (void)addOtherObserver {
    [NSThread detachNewThreadWithBlock:^{
        
        _timer2 = [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer)
                  {
                      NSLog(@"###cmm子线程###timer时间到");
                  }];
        
        _otherObserver = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
            switch (activity) {
                case kCFRunLoopEntry:
                    NSLog(@"###cmm子线程###进入kCFRunLoopEntry");
                    break;
                    
                case kCFRunLoopBeforeTimers:
                    NSLog(@"###cmm子线程###即将处理Timer事件");
                    break;
                    
                case kCFRunLoopBeforeSources:
                    NSLog(@"###cmm子线程###即将处理Source事件");
                    break;
                    
                case kCFRunLoopBeforeWaiting:
                    NSLog(@"###cmm子线程###即将休眠");
                    break;
                    
                case kCFRunLoopAfterWaiting:
                    NSLog(@"###cmm子线程###被唤醒");
                    break;
                    
                case kCFRunLoopExit:
                    NSLog(@"###cmm子线程###退出RunLoop");
                    break;
                    
                default:
                    break;
            }
        });
        
        CFRunLoopAddObserver(CFRunLoopGetCurrent(), _otherObserver, kCFRunLoopDefaultMode);
        [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        CFRunLoopRun();
    }];
}

@end
