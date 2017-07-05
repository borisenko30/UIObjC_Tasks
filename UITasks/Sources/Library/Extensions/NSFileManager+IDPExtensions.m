//
//  NSFileManager+IDPExtensions.m
//  UITask01
//
//  Created by Student003 on 7/3/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "NSFileManager+IDPExtensions.h"

#define IDPSingletonDirectory(tokenName, urlName, block)\
    static dispatch_once_t tokenName;\
    static NSURL *urlName = nil;\
    dispatch_once(&tokenName, block);

@implementation NSFileManager (IDPExtensions)

+ (NSURL *)documentsDirectoryUrl {
    IDPSingletonDirectory(onceToken, url, ^{url = [self urlForDirectory:NSDocumentDirectory];})

    return url;
}

+ (NSURL *)libraryDirectoryUrl {
    IDPSingletonDirectory(onceToken, url, ^{url = [self urlForDirectory:NSLibraryDirectory];})

    return url;
}

+ (NSURL *)libraryDirectoryUrlWithName:(NSString *)name {
    IDPSingletonDirectory(onceToken, url, ^{
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
    
    return url;
}

+ (NSURL *)localUrlWithFileName:(NSString *)name {
    return [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [self documentsDirectoryUrl].path, name]];
}

#pragma mark -
#pragma mark Private

+ (NSURL *)urlForDirectory:(NSSearchPathDirectory)directory {
    NSString *url = [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) firstObject];
    return  [NSURL URLWithString:url];
}

@end
