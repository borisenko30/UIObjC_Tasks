//
//  IDPModel+Extensions.h
//  UITask01
//
//  Created by Student003 on 7/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPModel.h"

typedef void(^IDPCompletionBlock)(id <NSCoding>);
typedef id <NSCoding>(^IDPLoadingBlock)();

@interface IDPModel (Extensions)

- (void)loadWithBlock:(IDPLoadingBlock)block completion:(IDPCompletionBlock)completion;

@end
