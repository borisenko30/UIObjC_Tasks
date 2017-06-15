//
//  IDPImageModel.m
//  UITask01
//
//  Created by Student003 on 6/15/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPImageModel.h"

#import "IDPImageModelDispatcher.h"

#import "IDPMacro.h"

@interface IDPImageModel ()
@property (nonatomic, strong) UIImage       *image;
@property (nonatomic, strong) NSURL         *url;
@property (nonatomic, strong) NSOperation   *operation;

- (NSOperation *)imageLoadingOperation;

@end

@implementation IDPImageModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)imageWithURL:(NSURL *)url {
    return [[self alloc] initWithUrl:url];
}

#pragma mark -
#pragma mark Deallocations and initializations

- (void)dealloc {
    self.operation = nil;
}

- (instancetype)initWithUrl:(NSURL *)url {
    self = [super init];
    self.url = url;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setOperation:(NSOperation *)operation {
    if (operation != _operation) {
        [_operation cancel];
        
        _operation = operation;
        
        if (operation) {
            IDPImageModelDispatcher *dispatcher = [IDPImageModelDispatcher sharedDispatcher];
            [dispatcher.queue addOperation:operation];
        }
    }
}

#pragma mark -
#pragma mark Public

- (void)load {
    @synchronized (self) {
        if (self.state == IDPImageModelLoading) {
            return;
        }
        
        if (self.state == IDPImageModelLoaded) {
            [self notifyOfStateChange:IDPImageModelLoaded];
        }
        
        self.state = IDPImageModelLoading;
    }
    
    self.operation = [self imageLoadingOperation];
}

- (void)dump {
    self.operation = nil;
    self.image = nil;
    self.state = IDPImageModelUnloaded;
}

#pragma mark -
#pragma mark Private

- (NSOperation *)imageLoadingOperation {
    IDPWeakify(self)
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        IDPStrongify(self)
        self.image = [UIImage imageWithContentsOfFile:[self.url absoluteString]];
    }];
    
    operation.completionBlock = ^{
        IDPStrongify(self)
        self.state = self.image ? IDPImageModelLoaded : IDPImageModelFailedLoading;
    };
    
    return operation;
}

@end
