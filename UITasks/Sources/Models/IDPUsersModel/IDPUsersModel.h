//
//  IDPUsersModel.h
//  UITask01
//
//  Created by Student003 on 6/19/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPArrayModel.h"

typedef void(^IDPCompletionBlock)(id <NSCoding>);
typedef id <NSCoding>(^IDPLoadingBlock)();

@interface IDPUsersModel : IDPArrayModel

- (void)save;

@end
