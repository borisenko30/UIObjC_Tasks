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

static NSString * const IDPUserName         = @"IDPUserName";
static NSString * const IDPImageName        = @"image";
static NSString * const IDPImageExtension   = @"jpg";

@interface IDPUser ()
@property (nonatomic, strong) NSString  *name;
@property (nonatomic, strong) NSString  *imageName;

@end

@implementation IDPUser

@dynamic imageModel;

#pragma mark -
#pragma mark Deallocations and initializations

- (instancetype)init {
    self = [super init];
    self.name = [NSString randomString];
    self.imageName = IDPImageName;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (IDPImageModel *)imageModel {
    NSURL *imageURL = [[NSBundle mainBundle] URLForResource:self.imageName withExtension:IDPImageExtension];
    
    return [IDPImageModel imageWithURL:imageURL];
}

#pragma mark -
#pragma mark NSCoding methods

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:IDPUserName];
    [aCoder encodeObject:self.imageName forKey:IDPImageName];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    self.name = [aDecoder decodeObjectForKey:IDPUserName];
    self.imageName = [aDecoder decodeObjectForKey:IDPImageName];
    
    return self;
}

@end
