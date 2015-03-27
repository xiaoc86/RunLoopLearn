//
//  RLInputSource.h
//  RunLoopLearn1
//
//  Created by 申超 on 15/3/27.
//  Copyright (c) 2015年 申超. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol RLInputSourceDelegate;
@class RLRunLoopContext;

@interface RLInputSource : NSObject

@property (nonatomic,assign) CFRunLoopSourceRef         runLoopSource;
@property (nonatomic,strong) NSMutableArray             * commonds;

@property (nonatomic,strong) id<RLInputSourceDelegate>                         delegate;

- (void) addToCurrentRunLoop;

- (void) removeFromCurrentRunLoop;

- (void) fireCommands:(NSString *) command onRunLoop:(RLRunLoopContext *) runLoopContext;

@end

// These are the CFRunLoopSourceRef callback functions.

//当将输入源附加到run loop时，调用这个协调调度例程，将源注册到客户端（可以理解为其他线程）
void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode);

//在输入源被告知（signal source）时，调用这个处理例程，这儿只是简单的调用了 [obj sourceFired]方法
void RunLoopSourcePerformRoutine (void *info);

//如果使用CFRunLoopSourceInvalidate/CFRunLoopRemoveSource函数把输入源从run loop里面移除的话，系统会调用这个取消例程，并且把输入源从注册的客户端（可以理解为其他线程）里面移除
void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode);

@interface RLRunLoopContext : NSObject

@property (nonatomic,strong,readonly) RLInputSource              * inputSource;
@property (nonatomic,assign,readonly) CFRunLoopRef               runLoop;

@end

@protocol RLInputSourceDelegate <NSObject>

- (id) initWithInputSource:(RLInputSource *) inputsource andRunLoop:(CFRunLoopRef) loop;

@end