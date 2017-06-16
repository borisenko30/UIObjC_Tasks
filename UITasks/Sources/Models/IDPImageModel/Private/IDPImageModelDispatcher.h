//
//  IDPImageModelDispatcher.h
//  UITask01
//
//  Created by Student003 on 6/15/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPImageModelDispatcher : NSObject
@property (nonatomic, readonly) NSOperationQueue *queue;

+ (instancetype)sharedDispatcher;

@end
