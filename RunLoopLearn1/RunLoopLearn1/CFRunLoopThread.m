//
//  CFRunLoopThread.m
//  RunLoopLearn1
//
//  Created by 申超 on 15/3/26.
//  Copyright (c) 2015年 申超. All rights reserved.
//

#import "CFRunLoopThread.h"

@implementation CFRunLoopThread

- (void) main
{
    @autoreleasepool {
        NSLog(@"CFRunLoopThread线程开始运行～～～～～");
        
//        NSTimer * timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerFireHnader) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        
        //scheduled开头的Timer构造会自动添加到当前RunLoop中
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireHnader) userInfo:nil repeats:YES];
        
        [self performSelector:@selector(performFireHander) withObject:nil afterDelay:0.1f];
        
        while (!self.isCancelled) {
            [self whileFireHander];
            ///运行 CFRunLoopRef: 参数为运行模式、时间和是否在处理Input Source后退出标志，返回值是exit原因
            //enum {
            //    kCFRunLoopRunFinished = 1, //Run Loop结束，没有Timer或者其他Input Source
            //    kCFRunLoopRunStopped = 2, //Run Loop被停止，使用CFRunLoopStop停止Run Loop
            //    kCFRunLoopRunTimedOut = 3, //Run Loop超时
            //    kCFRunLoopRunHandledSource = 4 ////Run Loop处理完事件，注意Timer事件的触发是不会让Run Loop退出返回的，即使CFRunLoopRunInMode的第三个参数是YES也不行
            //};
            SInt32 type = CFRunLoopRunInMode(kCFRunLoopDefaultMode, 10, YES);
            NSLog(@"CFRunLoopThread线程RunLoop运行结束~~~%d",type);
        }
        NSLog(@"CFRunLoopThread线程结束运行～～～～～");
    }
}

- (void) performFireHander
{
    NSLog(@"perform fired in CFRunLoopThread");
}

- (void) whileFireHander
{
    NSLog(@"while fired in CFRunLoopThread");
}

- (void) timerFireHnader
{
    NSLog(@"timer fired in CFRunLoopThread");
    //注意：总结，有Timer的时候需要手动结束RunLoop
    //不停止RunLoop会一直运行。
    //CFRunLoopStop(CFRunLoopGetCurrent());
}


@end
