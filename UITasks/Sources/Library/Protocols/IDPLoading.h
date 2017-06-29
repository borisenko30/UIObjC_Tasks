//
//  IDPLoading.h
//  UITask01
//
//  Created by Student003 on 6/28/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDPLoading <NSObject>
@property (nonatomic, assign, getter=isLoading)   BOOL      loading;

- (void)setLoading:(BOOL)loading
        animations:(void (^)())animations;

- (void)setLoading:(BOOL)loading
        animations:(void (^)())animations
 completionHandler:(void (^)(BOOL))completion;

@end
