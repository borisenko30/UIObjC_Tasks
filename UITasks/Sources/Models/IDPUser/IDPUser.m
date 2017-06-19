//
//  IDPUser.m
//  UITask01
//
//  Created by Student003 on 6/14/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPUser.h"

#import "IDPImageModel.h"

#import "NSString+IDPRandom.h"

@interface IDPUser ()
@property (nonatomic, strong) NSString *name;

@end

@implementation IDPUser

@dynamic imageModel;

#pragma mark -
#pragma mark Deallocations and initializations

- (instancetype)init {
    self = [super init];
    self.name = [NSString randomString];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (IDPImageModel *)imageModel {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"image" withExtension:@"jpg"];
    
    return [IDPImageModel imageWithURL:url];
}

@end
