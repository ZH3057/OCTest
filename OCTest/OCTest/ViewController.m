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

@interface ViewController ()

@property (nonatomic, strong) TestModelA *modelA;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /*
     //1.这段代码为什么会奔溃 奔溃的具体原因是什么
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
    
    [FPSMonitor start];
}


@end
