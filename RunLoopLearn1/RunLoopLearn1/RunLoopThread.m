//
//  RunLoopThread.m
//  RunLoopLearn1
//
//  Created by 申超 on 15/3/26.
//  Copyright (c) 2015年 申超. All rights reserved.
//

#import "RunLoopThread.h"

@implementation RunLoopThread

- (void)main
{
    @autoreleasepool {
        NSLog(@"RunLoopThread线程开始运行～～～～～");
        
//        NSTimer * timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerFireHnader) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        
        //scheduled开头的Timer构造会自动添加到当前RunLoop中
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireHnader) userInfo:nil repeats:YES];
        
        [self performSelector:@selector(performFireHander) withObject:nil afterDelay:4.0f];
        
    
        while (![self isCancelled]) {
            [self whileFireHander];
            //Timer不会使RunLoop返回，其他的事件会返回。
            BOOL result = [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            NSLog(@"RunLoopThread线程RunLoop运行结束~~~%d",result);
        }
        
        NSLog(@"RunLoopThread线程结束运行～～～～～");
    }
}

- (void) performFireHander
{
    NSLog(@"perform fired in RunLoopThread");
}

- (void) whileFireHander
{
    NSLog(@"while fired in RunLoopThread");
}

- (void) timerFireHnader
{
    NSLog(@"timer fired in RunLoopThread");
    
    //只有Timer情况下RunLoop不会停止，RunLoop会一直运行。
    //CFRunLoopStop(CFRunLoopGetCurrent());
}

@end
