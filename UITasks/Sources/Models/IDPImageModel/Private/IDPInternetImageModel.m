//
//  IDPInternetImageModel.m
//  UITask01
//
//  Created by Student003 on 7/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPInternetImageModel.h"

#import "IDPGCD.h"
#import "IDPMacro.h"

@interface IDPInternetImageModel ()
@property (nonatomic, strong)   NSURLSessionDownloadTask    *sessionTask;

@end

@implementation IDPInternetImageModel

#pragma mark -
#pragma mark Accessors

- (void)dealloc {
    self.sessionTask = nil;
}

#pragma mark -
#pragma mark Public Methods

- (void)loadWithCompletion:(IDPCompletionBlock)block {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    self.sessionTask = [session downloadTaskWithURL:self.url
                                                completionHandler:^(NSURL *location,
                                                                    NSURLResponse *response,
                                                                    NSError *error)
                                      {
                                          NSFileManager *fileManager = [NSFileManager defaultManager];
                                          
                                          NSURL *moveError;
                                          
                                          [fileManager moveItemAtURL:location toURL:self.localUrl error:&moveError];
                                          
                                          NSLog(@"moveError : %@", moveError);
                                          
                                          UIImage *image = [UIImage imageWithContentsOfFile:self.localUrl.path];
                                          block(image, error);
                                      }];
    
    [self.sessionTask resume];
}


@end
