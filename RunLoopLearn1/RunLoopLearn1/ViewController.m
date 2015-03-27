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
#import "RLInputSourceThread.h"
#import "RTInputSourceManager.h"

@interface ViewController ()

@property (nonatomic,assign) int                index;

@property (nonatomic,strong) UIButton           * addbutton;
@property (nonatomic,strong) UIButton           * firebutton;
@property (nonatomic,strong) UIButton           * delbutton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _index = 0;
    
    _addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addbutton.frame = CGRectMake(100, 100, 100, 100);
    [_addbutton setTitle:@"添加子线程" forState:UIControlStateNormal];
    [_addbutton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:_addbutton];
    [_addbutton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    
    _firebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    _firebutton.frame = CGRectMake(100, 200, 100, 100);
    [_firebutton setTitle:@"触发子线程" forState:UIControlStateNormal];
    [_firebutton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:_firebutton];
    [_firebutton addTarget:self action:@selector(fire) forControlEvents:UIControlEventTouchUpInside];
    
    _delbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    _delbutton.frame = CGRectMake(100, 300, 100, 100);
    [_delbutton setTitle:@"删除子线程" forState:UIControlStateNormal];
    [_delbutton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:_delbutton];
    [_delbutton addTarget:self action:@selector(del) forControlEvents:UIControlEventTouchUpInside];
}

- (void) add
{
    [[RTInputSourceManager shareInstance] inputSourceThreadStart];
}

- (void) fire
{
    _index ++;
    [[RTInputSourceManager shareInstance] fireInput:[NSString stringWithFormat:@"测试%d",_index]];
}

- (void) del
{
     //[[RTInputSourceManager shareInstance] fireInput:@"测试"];
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
