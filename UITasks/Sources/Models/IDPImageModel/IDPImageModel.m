//
//  IDPImageModel.m
//  IDPUITask1
//
//  Created by Student003 on 6/28/17.
//  Copyright © 2017 Student004. All rights reserved.
//

#import "IDPImageModel.h"

#import "IDPMacro.h"
#import "IDPImageModelDispatcher.h"

@interface IDPImageModel ()
@property (nonatomic, strong)     UIImage           *image;
@property (nonatomic, strong)     NSURL             *url;
@property (nonatomic, strong)     NSOperation       *operation;

- (NSOperation *)imageLoadingOperation;

@end

@implementation IDPImageModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)imageWithURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.operation = nil;
}

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        self.url = url;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setOperation:(NSOperation *)operation {
    if (_operation != operation) {
        [_operation cancel];
        
        _operation = operation;
        
        if (operation) {
            IDPImageModelDispatcher *dispatcher = [IDPImageModelDispatcher sharedDispatcher];
            [dispatcher.queue addOperation:operation];
        }
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)processLoading {
    self.operation = [self imageLoadingOperation];
}

- (void)dump {
    self.operation = nil;
    self.image = nil;
    self.state = IDPModelDidUnload;
}

#pragma mark -
#pragma mark Private

- (NSOperation *)imageLoadingOperation {
    IDPWeakify(self);
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        IDPStrongifyAndReturnIfNil(self);
        self.image = [UIImage imageWithContentsOfFile:self.url.path];
    }];
    
    operation.completionBlock = ^{
        IDPStrongifyAndReturnIfNil(self);
        self.state = self.image ? IDPModelDidLoad : IDPModelDidFailLoading;
    };
    
    return operation;
}

@end
