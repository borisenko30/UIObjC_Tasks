//
//  IDPImageCache.h
//  UITask01
//
//  Created by Student003 on 7/3/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPImageModel;

@interface IDPCache : NSObject
@property (nonatomic, readonly) NSDictionary *imageModels;

+ (instancetype)sharedCache;

- (void)setModel:(IDPImageModel *)model URL:(NSURL *)url;
- (void)removeModelForURL:(NSURL *)url;
- (IDPImageModel *)modelForURL:(NSURL *)url;

@end
