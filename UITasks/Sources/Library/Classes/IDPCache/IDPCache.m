//
//  IDPImageCache.m
//  UITask01
//
//  Created by Student003 on 7/3/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPCache.h"

#import "IDPImageModel.h"

@interface IDPCache ()
@property (nonatomic, strong) NSMapTable *models;

@end

@implementation IDPCache

#pragma mark -
#pragma mark Singleton method

+ (instancetype)sharedCache {
    static dispatch_once_t onceToken;
    static IDPCache *sharedCache = nil;
    
    dispatch_once(&onceToken, ^{
        sharedCache = [self new];
    });
    
    return sharedCache;
}

#pragma mark -
#pragma mark Deallocations and initializations

- (instancetype)init {
    self = [super init];
    self.models = [NSMapTable strongToWeakObjectsMapTable];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSDictionary *)imageModels {
    @synchronized (self) {
        return [self.models dictionaryRepresentation];
    }
}

#pragma mark -
#pragma mark Public

- (void)setModel:(IDPImageModel *)model URL:(NSURL *)url {
    @synchronized (self) {
        [self.models setObject:model forKey:url];
    }
}

- (void)removeModelForURL:(NSURL *)url {
    @synchronized (self) {
        [self.models removeObjectForKey:url];
    }
}

- (IDPImageModel *)modelForURL:(NSURL *)url {
    @synchronized (self) {
        return [self.models objectForKey:url];
    }
}

@end
