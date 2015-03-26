//
//  ViewController.m
//  RunLoopLearn1
//
//  Created by 申超 on 15/3/24.
//  Copyright (c) 2015年 申超. All rights reserved.
//

#import "ViewController.h"
#import "RunLoopThread.h"
#import "CFRunLoopThread.h"
#import "ObserverThread.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self runLoopThreadStart];
    //[self cfRunLoopThreadStart];
    [self observerThreadStart];
}

- (void) runLoopThreadStart
{
    RunLoopThread * rlt = [[RunLoopThread alloc] init];
    [rlt start];
}

- (void) cfRunLoopThreadStart
{
    CFRunLoopThread * cft = [[CFRunLoopThread alloc] init];
    [cft start];
}

- (void) observerThreadStart
{
    ObserverThread * ot = [[ObserverThread alloc] init];
    [ot start];
}


@end
