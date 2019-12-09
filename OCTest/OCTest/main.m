//
//  main.m
//  OCTest
//
//  Created by Jun Zhou on 2019/4/15.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

typedef void (^TestBlock)(void);

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
//        __block NSString *test = @"test";
//        __block NSInteger i = 1;
//        TestBlock block = ^(void){
//            dispatch_sync(dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL), ^{
//                NSLog(@"%@, %zd", test, i);
//                NSLog(@"%@", NSThread.currentThread);
//            });
//        };
//        
//        test = @"test1";
//        i = 2;
//        block();
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
