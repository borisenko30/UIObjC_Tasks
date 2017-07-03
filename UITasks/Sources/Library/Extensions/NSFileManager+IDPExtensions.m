//
//  NSFileManager+IDPExtensions.m
//  UITask01
//
//  Created by Student003 on 7/3/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "NSFileManager+IDPExtensions.h"

@implementation NSFileManager (IDPExtensions)

+ (NSURL *)documentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSURL *)libraryDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSURL *)libraryDirectoryWithName:(NSString *)name {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *libraryPath = [self libraryDirectory].path;
    NSString *namePath = [libraryPath stringByAppendingPathComponent:name];
    if (![fileManager fileExistsAtPath:namePath]) {
        if ([fileManager createDirectoryAtPath:namePath withIntermediateDirectories:NO attributes:nil error:nil]) {
            return [NSURL fileURLWithPath:namePath];
        }
    }
    
    return nil;
}

@end
