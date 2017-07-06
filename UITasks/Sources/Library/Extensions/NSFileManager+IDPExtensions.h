//
//  NSFileManager+IDPExtensions.h
//  UITask01
//
//  Created by Student003 on 7/3/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (IDPExtensions)

+ (NSURL *)documentsDirectoryUrl;
+ (NSURL *)libraryDirectoryUrl;
+ (NSURL *)libraryDirectoryUrlWithName:(NSString *)name;

@end
