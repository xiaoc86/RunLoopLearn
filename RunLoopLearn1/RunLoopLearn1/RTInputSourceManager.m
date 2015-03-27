//
//  RTInputSourceManager.m
//  RunLoopLearn1
//
//  Created by 申超 on 15/3/27.
//  Copyright (c) 2015年 申超. All rights reserved.
//

#import "RTInputSourceManager.h"
#import "RLInputSource.h"
#import "RLInputSourceThread.h"

@interface RTInputSourceManager ()

@property (nonatomic,strong) NSMutableArray             * contextArray;

@end

@implementation RTInputSourceManager


+ (RTInputSourceManager *) shareInstance
{
    static RTInputSourceManager * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RTInputSourceManager alloc] init];
    });
    return instance;
}

- (id) init
{
    self = [super init];
    if (self) {
        _contextArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) fireInput:(NSString *) command
{
    for (RLRunLoopContext * context in self.contextArray) {
        [context.inputSource fireCommands:command onRunLoop:context];
    }
}


- (void) inputSourceThreadStart
{
    RLInputSourceThread * rlist = [[RLInputSourceThread alloc] init];
    [rlist start];
}

- (void) registInput:(RLRunLoopContext *) context
{
    [_contextArray addObject:context];
}

- (void) removeInput:(RLRunLoopContext *) context
{
    for (RLRunLoopContext * temp in self.contextArray) {
        if ([temp.inputSource isEqual:context.inputSource]) {
            [self.contextArray removeObject:temp];
        }
    }
}


@end
