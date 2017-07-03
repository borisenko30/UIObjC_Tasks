//
//  NSFileManager+IDPExtensions.h
//  UITask01
//
//  Created by Student003 on 7/3/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (IDPExtensions)

+ (NSURL *)documentsDirectory;
+ (NSURL *)libraryDirectory;
+ (NSURL *)libraryDirectoryWithName:(NSString *)name;

+ (NSString *)pathWithFileName:(NSString *)name ;

@end
