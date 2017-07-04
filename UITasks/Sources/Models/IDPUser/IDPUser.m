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
static NSString * const IDPImageURL         = @"http://img1.joyreactor.cc/pics/post/%D0%BA%D0%BE%D1%82%D1%8D-%D0%B6%D0%B8%D0%B2%D0%BD%D0%BE%D1%81%D1%82%D1%8C-3934357.jpeg";

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
    return [IDPImageModel imageWithURL:[NSURL URLWithString:IDPImageURL]];
}

#pragma mark -
#pragma mark NSCoding methods

#define IDPEncodeObjectForKey(object, key) \
    [aCoder encodeObject:object forKey:key];

- (void)encodeWithCoder:(NSCoder *)aCoder {
    IDPEncodeObjectForKey(self.name, IDPUserName)
    IDPEncodeObjectForKey(self.imageName, IDPImageName)
}

#undef IDPEncodeObjectForKey

#define IDPDecodeObjectForKey(object, key) \
    object = [aDecoder decodeObjectForKey:key];

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    IDPDecodeObjectForKey(self.name, IDPUserName)
    IDPDecodeObjectForKey(self.imageName, IDPImageName)
    
    return self;
}

#undef IDPDecodeObjectForKey

@end
