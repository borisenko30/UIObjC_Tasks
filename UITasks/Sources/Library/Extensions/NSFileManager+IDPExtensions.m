//
//  NSFileManager+IDPExtensions.m
//  UITask01
//
//  Created by Student003 on 7/3/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "NSFileManager+IDPExtensions.h"

@implementation NSFileManager (IDPExtensions)

+ (NSURL *)documentsDirectoryUrl {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSURL *)libraryDirectoryUrl {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSURL *)libraryDirectoryUrlWithName:(NSString *)name {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *libraryPath = [self libraryDirectoryUrl].path;
    NSString *namePath = [libraryPath stringByAppendingPathComponent:name];
    if (![fileManager fileExistsAtPath:namePath]) {
        if ([fileManager createDirectoryAtPath:namePath withIntermediateDirectories:NO attributes:nil error:nil]) {
            return [NSURL fileURLWithPath:namePath];
        }
    }
    
    return nil;
}

+ (NSString *)pathWithFileName:(NSString *)name {
    return [NSString stringWithFormat:@"%@/%@", [self documentsDirectoryUrl].path, name];
}

@end
