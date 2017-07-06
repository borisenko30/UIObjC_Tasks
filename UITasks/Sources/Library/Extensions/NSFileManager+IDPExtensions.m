//
//  NSFileManager+IDPExtensions.m
//  UITask01
//
//  Created by Student003 on 7/3/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "NSFileManager+IDPExtensions.h"

#define IDPSingletonDirectory(block)\
    static dispatch_once_t onceToken;\
    static NSURL *url = nil;\
    dispatch_once(&onceToken, block);\
    return url;

#define IDPUrlForDirectory(directory)\
    IDPSingletonDirectory(^{url = [self urlForDirectory:directory];})

@implementation NSFileManager (IDPExtensions)

+ (NSURL *)documentsDirectoryUrl {
    IDPUrlForDirectory(NSDocumentDirectory)
}

+ (NSURL *)libraryDirectoryUrl {
    IDPUrlForDirectory(NSLibraryDirectory)
}

+ (NSURL *)libraryDirectoryUrlWithName:(NSString *)name {
    IDPSingletonDirectory(^{
        NSURL *libraryURL = [NSFileManager libraryDirectoryUrl];
        NSError *error;
        NSString *filePath = [libraryURL.path stringByAppendingPathComponent:name];
        BOOL result = [[NSFileManager defaultManager] createDirectoryAtPath:filePath
                                                withIntermediateDirectories:YES
                                                                 attributes:nil
                                                                      error:&error];
        if (!result) {
            NSLog(@"Create directory error: %@", error);
        }
        
        url = [NSURL URLWithString:filePath];
    })
}

#pragma mark -
#pragma mark Private

+ (NSURL *)urlForDirectory:(NSSearchPathDirectory)directory {
    NSString *url = [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) firstObject];
    return  [NSURL URLWithString:url];
}

@end
