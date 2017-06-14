//
//  IDPUser.m
//  UITask01
//
//  Created by Student003 on 6/14/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPUser.h"

#import "NSString+IDPRandom.h"

@interface IDPUser ()
@property (nonatomic, strong) NSString *name;

@end

@implementation IDPUser

- (instancetype)init {
    self = [super init];
    self.name = [NSString randomString];
    
    return self;
}

@end
