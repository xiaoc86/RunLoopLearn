//
//  ObserverThread.m
//  RunLoopLearn1
//
//  Created by 申超 on 15/3/26.
//  Copyright (c) 2015年 申超. All rights reserved.
//

#import "ObserverThread.h"

@implementation ObserverThread
//1）通知观察者Run Loop已经启动
//2）通知观察者任何即将要开始的定时器
//3）通知观察者任何即将启动的非基于端口的输入源
//4）启动任何准备好的非基于端口的源
//5）如果基于端口的源准备好了并处于等待状态，立即启动；并进入步骤9
//6）通知观察者线程进入休眠
//7）将线程置于休眠直到下面任一事件发生
//  A）某一事件到达基于端口的源
//  B）定时器启动
//  C）Run Loop设置的时间已经超时
//  D）Run Loop被显式唤醒
//8）通知观察者线程被唤醒
//9）处理未处理的事件
//  A）如果用户定义的定时器启动，处理定时器事件并重启Run Loop，进入步骤2
//  B）如果输入源启动，传递相应消息
//  C）如果Run Loop被显式唤醒而且时间还没有超时，重启Run Loop，进入步骤2
//10）通知观察者Run Loop结束
void observerCallBackFuntion(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"kCFRunLoopEntry");
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"kCFRunLoopBeforeTimers");
            break;
        case kCFRunLoopBeforeSources:
            NSLog(@"kCFRunLoopBeforeSources");
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"kCFRunLoopBeforeWaiting");
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@"kCFRunLoopAfterWaiting");
            break;
        case kCFRunLoopExit:
            NSLog(@"kCFRunLoopExit");
            break;
        default:
            break;
    }
}


- (void) main
{
    @autoreleasepool {
        
        NSLog(@"ObserverThread线程开始运行～～～～～");
        
        //[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireHnader) userInfo:nil repeats:YES];
        
        [self performSelector:@selector(performFireHander) withObject:nil afterDelay:0.1f];
        
        CFRunLoopObserverContext context = {0,(__bridge void *)(self),NULL,NULL,NULL};
        // 第一个参数用于分配该observer对象的内存
        // 第二个参数用以设置该observer所要关注的的事件，详见回调函数myRunLoopObserver中注释
        // 第三个参数用于标识该observer是在第一次进入run loop时执行还是每次进入run loop处理时均执行
        // 第四个参数用于设置该observer的优先级
        // 第五个参数用于设置该observer的回调函数
        // 第六个参数用于设置该observer的运行环境
        CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &observerCallBackFuntion, &context);
        
        if (observer) {
            CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
        }
        
        while (!self.isCancelled) {
            [self whileFireHander];
            // 启动当前thread的run loop直到所指定的时间到达，在run loop运行时，run loop会处理所有来自与该run loop联系的input sources的数据
            // 对于本例与当前run loop联系的input source只有Timer类型的source
            // 该Timer每隔0.1秒发送触发时间给run loop，run loop检测到该事件时会调用相应的处理方法（timerFireHnader:）
            // 由于在run loop添加了observer，且设置observer对所有的run loop行为感兴趣
            // 当调用runUntilDate方法时，observer检测到run loop启动并进入循环，observer会调用其回调函数，第二个参数所传递的行为时kCFRunLoopEntry
            // observer检测到run loop的其他行为并调用回调函数的操作与上面的描述相类似
            SInt32 result = CFRunLoopRunInMode(kCFRunLoopDefaultMode, 10, YES);
            NSLog(@"ObserverThread线程的RunLoop结束～～～%d",result);
        }
        
        NSLog(@"ObserverThread线程开始运行～～～～～");
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
