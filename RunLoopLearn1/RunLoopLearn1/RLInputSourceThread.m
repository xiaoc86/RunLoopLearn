//
//  RLInputSourceThread.m
//  RunLoopLearn1
//
//  Created by 申超 on 15/3/27.
//  Copyright (c) 2015年 申超. All rights reserved.
//

#import "RLInputSourceThread.h"
#import "RLInputSource.h"

@implementation RLInputSourceThread

- (void) main
{
    @autoreleasepool {
        
        NSLog(@"RLInputSourceThread线程开始运行～～～～～");
        
        RLInputSource * inputSource = [[RLInputSource alloc] init];
        [inputSource addToCurrentRunLoop];
        
        while (!self.isCancelled) {
            [self whileFireHander];
            
            BOOL result = [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            NSLog(@"RLInputSourceThread线程的RunLoop结束～～～%d",result);
        }
        
        NSLog(@"RLInputSourceThread线程开始运行～～～～～");
    }
}

- (void) performFireHander
{
    NSLog(@"perform fired in RLInputSourceThread");
}

- (void) whileFireHander
{
    NSLog(@"while fired in RLInputSourceThread");
}

@end
