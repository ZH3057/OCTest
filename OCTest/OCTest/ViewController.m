//
//  ViewController.m
//  OCTest
//
//  Created by Jun Zhou on 2019/4/15.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import "ViewController.h"
#import "TestModelA.h"
#import "CpuUsage.h"
#import "FPSMonitor.h"
#import "MemoryUsage.h"
#import "PerformanceMonitor.h"
#import <Masonry.h> 

@interface ViewController ()

@property (nonatomic, strong) TestModelA *modelA;

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.modelA = [[TestModelA alloc] init];
    
    self.queue = [[NSOperationQueue alloc] init];
    
    /*
     //1.这段代码为什么会奔溃 奔溃的具体原因是什么
     
     调用set方法会执行
     if (_modleB != modelB) {
        [modelB retain];
        [_modelB release];
         _modelB = modelB;
     }
     多线程去执行[_modelB release]操作造成坏内存访问
     
    self.modelA = [[TestModelA alloc] init];
    dispatch_queue_t concurrent_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 1000; i++) {
        //NSLog(@"idx: %d", i);
        dispatch_async(concurrent_queue, ^{
            self.modelA.modelB = [[TestModelB alloc] init];
            //NSLog(@"%@", [NSThread currentThread]);
        });
    }
    */
    
    
    /*
    UILabel *dispalyLabel = [[UILabel alloc] init];
    dispalyLabel.text = @"显示";
    dispalyLabel.opaque = YES;
    dispalyLabel.layer.masksToBounds = YES;
    //dispalyLabel.layer.cornerRadius = 10;
    dispalyLabel.backgroundColor = UIColor.grayColor;
    dispalyLabel.font = [UIFont systemFontOfSize:30];
    dispalyLabel.textColor = UIColor.blackColor;
    dispalyLabel.textAlignment = NSTextAlignmentCenter;
    dispalyLabel.frame = CGRectMake(10, 100, 300, 100);
    [self.view addSubview:dispalyLabel];
     */
    
    /*
    while (1) {
        NSLog(@"CPU usage: %d", [CpuUsage cpuUseage]);
    }
     */
    
    /*
    [FPSMonitor start];
     */
    
    /*
    while (1) {
        NSLog(@"CPU usage: %llu", [MemoryUsage memoryUsage]);
    }
      */
    
    /*
    [PerformanceMonitor addOtherObserver];
    [PerformanceMonitor addmainRunloopObserver];
     */
    
    
    /*
    if (YES) {
        NSLog(@"jump goto msg_hander");
        goto msg_hander;
    }
    NSLog(@"after goto msg_hander");
    
    msg_hander:;
     NSLog(@"do msg_hander");
     */
    
    /*
    float num1 = 0.5;
    float num2 = 0.6;
    if (num1 > num2) {
        NSLog(@"num1 > num2");
    } else {
        NSLog(@"num1 < num2");
    }*/
    
//    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 44, CGRectGetWidth(self.view.bounds), 44)];
//    [self.view addSubview:slider];
//
//    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.bottom.left.right.equalTo(self.view);
//        make.height.equalTo(@44);
//    }];
    

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//        NSLog(@"before target task invoke");
        //dispatch_queue_t serial_queue = dispatch_queue_create("custom.test.queue", NULL);
    //    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //        NSLog(@"target task invoke in thread: %@", NSThread.currentThread);
    //    });
    //    dispatch_queue_t concurrent_queue = dispatch_queue_create("custom.test.queue", DISPATCH_QUEUE_CONCURRENT);
    //    dispatch_async(concurrent_queue, ^{
    //        dispatch_sync(concurrent_queue, ^{
    //            NSLog(@"1.target task invoke in thread: %@", NSThread.currentThread);
    //        });
    //
    //        dispatch_sync(concurrent_queue, ^{
    //            NSLog(@"2.target task invoke in thread: %@", NSThread.currentThread);
    //        });
    //
    //        dispatch_sync(concurrent_queue, ^{
    //            NSLog(@"3.target task invoke in thread: %@", NSThread.currentThread);
    //        });
    //    });
        
        //dispatch_queue_t serial_queue = dispatch_queue_create("custom.test.queue", NULL);
//        dispatch_queue_t concurrent_queue = dispatch_queue_create("custom.test.queue", DISPATCH_QUEUE_CONCURRENT);
//        dispatch_apply(10, concurrent_queue, ^(size_t i) {
//            NSLog(@"%zu - target task invoke in thread: %@" , i, NSThread.currentThread);
//        });
//
//        NSLog(@"after target task invoke");
    
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperationSel) object:nil];
    [self.queue addOperation:operation];
    
    NSBlockOperation *blkOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation invoke in thread: %@", NSThread.currentThread);
    }];
    
    [self.queue addOperation:blkOperation];
}

- (void)invocationOperationSel {
    NSLog(@"NSInvocationOperation invoke in thread: %@", NSThread.currentThread);
}

@end
