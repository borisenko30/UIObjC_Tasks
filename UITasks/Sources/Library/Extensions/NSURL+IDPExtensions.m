//
//  NSURL+IDPExtensions.m
//  UITask01
//
//  Created by Student003 on 7/6/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "NSURL+IDPExtensions.h"

#import "NSFileManager+IDPExtensions.h"

@implementation NSURL (IDPExtensions)

- (instancetype)fileSystemURL {
    NSString *fileName = [self.relativePath
                              stringByAddingPercentEncodingWithAllowedCharacters:
                              [NSCharacterSet alphanumericCharacterSet]];

    NSString *path =[NSString stringWithFormat:@"%@/%@%@",
                                [NSFileManager documentsDirectoryUrl].path,
                                self.host,
                                fileName];
    
    return [NSURL fileURLWithPath:path];
}

@end
