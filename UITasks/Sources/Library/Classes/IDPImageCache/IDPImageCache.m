//
//  IDPImageCache.m
//  UITask01
//
//  Created by Student003 on 7/3/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPImageCache.h"

#import "IDPImageModel.h"

@interface IDPImageCache ()
@property (nonatomic, strong) NSMapTable *models;

@end

@implementation IDPImageCache

#pragma mark -
#pragma mark Singleton method

+ (instancetype)sharedCache {
    static dispatch_once_t onceToken;
    static IDPImageCache *sharedCache = nil;
    
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

- (void)setImageModel:(IDPImageModel *)model URL:(NSURL *)url {
    @synchronized (self) {
        [self.models setObject:model forKey:url];
    }
}

- (void)removeImageModelForURL:(NSURL *)url {
    @synchronized (self) {
        [self.models removeObjectForKey:url];
    }
}

- (IDPImageModel *)imageModelForURL:(NSURL *)url {
    @synchronized (self) {
        return [self.models objectForKey:url];
    }
}

@end
