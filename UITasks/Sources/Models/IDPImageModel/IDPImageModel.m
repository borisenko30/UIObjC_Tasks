//
//  IDPImageModel.m
//  IDPUITask1
//
//  Created by Student003 on 6/28/17.
//  Copyright © 2017 Student004. All rights reserved.
//

#import "IDPImageModel.h"

#import "IDPImageCache.h"
#import "IDPImageModelDispatcher.h"

#import "IDPMacro.h"
#import "IDPGCD.h"

#import "NSFileManager+IDPExtensions.h"

@interface IDPImageModel ()
@property (nonatomic, strong)     UIImage           *image;
@property (nonatomic, strong)     NSURL             *url;
@property (nonatomic, strong)     NSOperation       *operation;
@property (nonatomic, strong)     NSString          *imageName;
@property (nonatomic, strong)     NSString          *filePath;
@property (nonatomic, strong)     IDPImageCache     *cache;

- (void)initModelWithUrl:(NSURL *)url;

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

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];

    self.url = url;
    self.imageName = [url lastPathComponent];
    [self initModelWithUrl:url];
    
    return self;
}

- (void)initModelWithUrl:(NSURL *)url {
    IDPImageCache *sharedCache = [IDPImageCache sharedCache];
    NSDictionary *models = sharedCache.imageModels;
    id model = [models objectForKey:url];
    
    if (model) {
        [self performBlock:^{
            [self dump];
        } shouldNotify:NO];
        
        [sharedCache setImageModel:model URL:url];
    } else {
        [sharedCache setImageModel:self URL:url];
    }
}

#pragma mark -
#pragma mark Accessors

- (NSString *)filePath {
    return [NSFileManager pathWithFileName:self.imageName];
}

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

- (UIImage *)imageWithUrl:(NSURL *)url {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = self.filePath;
    __block NSData *data;
    __block UIImage *image = nil;
    
    if ([fileManager fileExistsAtPath:filePath]) {
        data = [NSData dataWithContentsOfFile:filePath];
        
        if (data) {
            image = [UIImage imageWithData:data];
        } else {
            //handle error
        }
    } else {
        data = [[NSData alloc] initWithContentsOfURL:url];
        
        if (data) {
            [data writeToFile:filePath atomically:YES];
        }
        
        image = [UIImage imageWithData:data];
    }
    
    return image;
}

- (void)dump {
    self.image = nil;
    self.imageName = nil;
    self.filePath = nil;
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
        //self.image = [UIImage imageWithContentsOfFile:self.url.path];
        self.image = [self imageWithUrl:self.url];
    }];
    
    operation.completionBlock = ^{
        IDPStrongifyAndReturnIfNil(self);
        self.state = self.image ? IDPModelDidLoad : IDPModelDidFailLoading;
    };
    
    return operation;
}

@end
