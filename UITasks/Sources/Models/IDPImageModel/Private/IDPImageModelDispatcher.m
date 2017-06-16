//
//  IDPImageModelDispatcher.m
//  UITask01
//
//  Created by Student003 on 6/15/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPImageModelDispatcher.h"

@interface IDPImageModelDispatcher ()
@property (nonatomic, strong) NSOperationQueue *queue;

- (void)initQueue;

@end

@implementation IDPImageModelDispatcher

#pragma mark -
#pragma mark Class methods

+ (instancetype)sharedDispatcher {
    static dispatch_once_t onceToken;
    static id dispatcher = nil;
    dispatch_once(&onceToken, ^{
        dispatcher  = [self new];
    });
    
    return dispatcher;
}

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.queue = nil;
}

- (instancetype)init {
    self = [super init];
    [self initQueue];
    
    return self;
}

- (void)initQueue {
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.maxConcurrentOperationCount = 2;
    
    self.queue = queue;
}

#pragma mark -
#pragma mark Accessors

- (void)setQueue:(NSOperationQueue *)queue {
    if (_queue != queue) {
        [_queue cancelAllOperations];
        
        _queue = queue;
    }
}

@end
