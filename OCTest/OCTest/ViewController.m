//
//  ViewController.m
//  OCTest
//
//  Created by Jun Zhou on 2019/4/15.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import "ViewController.h"
#import "TestModelA.h"

@interface ViewController ()

@property (nonatomic, strong) TestModelA *modelA;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     1.这段代码为什么会奔溃 奔溃的具体原因是什么
    self.modelA = [[TestModelA alloc] init];
    dispatch_queue_t concurrent_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 1000; i++) {
        //NSLog(@"idx: %d", i);
        dispatch_async(concurrent_queue, ^{
            self.modelA.modelB = [[TestModelB alloc] init];
        });
    }
     */
    
    UILabel *dispalyLabel = [[UILabel alloc] init];
}


@end
