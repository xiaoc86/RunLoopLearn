//
//  RTInputSourceManager.h
//  RunLoopLearn1
//
//  Created by 申超 on 15/3/27.
//  Copyright (c) 2015年 申超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RLInputSource.h"

@interface RTInputSourceManager : NSObject

+ (RTInputSourceManager *) shareInstance;

- (void) inputSourceThreadStart;
- (void) fireInput:(NSString *) command;


- (void) registInput:(RLRunLoopContext *) context;

- (void) removeInput:(RLRunLoopContext *) context;

@end
