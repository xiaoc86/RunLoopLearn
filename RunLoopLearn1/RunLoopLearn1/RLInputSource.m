//
//  RLInputSource.m
//  RunLoopLearn1
//
//  Created by 申超 on 15/3/27.
//  Copyright (c) 2015年 申超. All rights reserved.
//

#import "RLInputSource.h"
#import "RTInputSourceManager.h"

@implementation RLInputSource

- (id) init
{
    self = [super init];
    if (self) {
        CFRunLoopSourceContext context = {0,(__bridge void *)(self),NULL,NULL,NULL,NULL,NULL,
            &RunLoopSourceScheduleRoutine,&RunLoopSourceCancelRoutine,&RunLoopSourcePerformRoutine};
        
        _runLoopSource = CFRunLoopSourceCreate(NULL, 0, &context);
        _commonds = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addToCurrentRunLoop
{
    CFRunLoopAddSource(CFRunLoopGetCurrent(), _runLoopSource, kCFRunLoopDefaultMode);
}

- (void) removeFromCurrentRunLoop
{
    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), _runLoopSource, kCFRunLoopDefaultMode);
}

- (void) fireCommands:(NSString *) command onRunLoop:(RLRunLoopContext *) runLoopContext
{
    [_commonds addObject:command];
    CFRunLoopSourceSignal(runLoopContext.inputSource.runLoopSource);
    CFRunLoopWakeUp(runLoopContext.runLoop);
}

- (void) fireDo
{
    NSLog(@"fireDo~~~~ %@ ~~~%@",[_commonds objectAtIndex:0],[NSThread currentThread]);
}

@end


@interface RLRunLoopContext ()

@property (nonatomic,strong,readwrite) RLInputSource              * inputSource;
@property (nonatomic,assign,readwrite) CFRunLoopRef               runLoop;

@end

@implementation RLRunLoopContext

- (id) initWithInputSource:(RLInputSource *) inputsource andRunLoop:(CFRunLoopRef) loop
{
    self = [super init];
    if (self) {
        _inputSource = inputsource;
        _runLoop = loop; 
    }
    return self;
}

@end


//当将输入源附加到run loop时，调用这个协调调度例程，将源注册到客户端（可以理解为其他线程）
void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    RLInputSource * inputSource = (__bridge RLInputSource *)(info);
    [[RTInputSourceManager shareInstance] registInput:[[RLRunLoopContext alloc] initWithInputSource:inputSource andRunLoop:CFRunLoopGetCurrent()]];
}

//在输入源被告知（signal source）时，调用这个处理例程，这儿只是简单的调用了 [obj sourceFired]方法
void RunLoopSourcePerformRoutine (void *info)
{
    RLInputSource * inputSource = (__bridge RLInputSource *)(info);
    [inputSource fireDo];
}

//如果使用CFRunLoopSourceInvalidate/CFRunLoopRemoveSource函数把输入源从run loop里面移除的话，系统会调用这个取消例程，并且把输入源从注册的客户端（可以理解为其他线程）里面移除
void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    RLInputSource * inputSource = (__bridge RLInputSource *)(info);
    [[RTInputSourceManager shareInstance] removeInput:[[RLRunLoopContext alloc] initWithInputSource:inputSource andRunLoop:CFRunLoopGetCurrent()]];
}