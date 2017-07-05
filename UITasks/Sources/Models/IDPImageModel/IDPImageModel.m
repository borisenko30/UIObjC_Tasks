//
//  IDPImageModel.m
//  IDPUITask1
//
//  Created by Student003 on 6/28/17.
//  Copyright © 2017 Student004. All rights reserved.
//

#import "IDPImageModel.h"

#import "IDPFileSystemImageModel.h"
#import "IDPInternetImageModel.h"

#import "IDPMacro.h"
#import "IDPGCD.h"

#import "NSFileManager+IDPExtensions.h"

@interface IDPImageModel ()
@property (nonatomic, strong)     UIImage           *image;
@property (nonatomic, strong)     NSURL             *url;
@property (nonatomic, strong)     NSURL             *localUrl;
@property (nonatomic, strong)     IDPCache          *cache;

@end

@implementation IDPImageModel

@dynamic cache;
@dynamic localUrl;

#pragma mark -
#pragma mark Class Methods

#pragma mark -
#pragma mark Class Methods

+ (instancetype)modelWithURL:(NSURL *)url {
    IDPCache *cache = [IDPCache sharedCache];
    id model = [cache modelForKey:url];
    if (model) {
        return model;
    }
    
    Class class = [url isFileURL] ? [IDPFileSystemImageModel class] : [IDPInternetImageModel class];
    model = [class alloc] initWithURL:url];
    [cache setObject:model forKey:url];
    
    return model;
    
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];

    self.url = url;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (IDPImageCache *)cache {
    return [IDPImageCache sharedCache];
}

- (NSURL *)localUrl {
    return [NSFileManager localUrlWithFileName:[self.url lastPathComponent]];
}

#pragma mark -
#pragma mark Public Methods

- (void)performLoading {
    [self loadWithCompletion:^(UIImage *image, NSError *error) {
        self.image = image;
        if (error) {
            //[self setState:IDPModelDidFailLoading withObject:error];
        } else {
            self.state = IDPModelDidLoad;
        }
    }];
}

- (void)loadWithCompletion:(IDPCompletionBlock)block {
    
}

@end
