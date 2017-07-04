//
//  IDPImageModel.m
//  IDPUITask1
//
//  Created by Student003 on 6/28/17.
//  Copyright © 2017 Student004. All rights reserved.
//

#import "IDPImageModel.h"

#import "IDPImageCache.h"

#import "IDPMacro.h"
#import "IDPGCD.h"

#import "NSFileManager+IDPExtensions.h"
#import "IDPModel+Extensions.h"

@interface IDPImageModel ()
@property (nonatomic, strong)     UIImage           *image;
@property (nonatomic, strong)     NSURL             *url;
@property (nonatomic, strong)     NSString          *imageName;
@property (nonatomic, strong)     NSString          *filePath;
@property (nonatomic, strong)     IDPImageCache     *cache;

@end

@implementation IDPImageModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)imageWithURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];

    self.url = url;
    self.imageName = [url lastPathComponent];
    
    self = [self initFromCacheWithURL:url];
    
    return self;
}

- (instancetype)initFromCacheWithURL:(NSURL *)url {
    IDPImageCache *cache = self.cache;
    
    id model = [cache.imageModels objectForKey:url];
    
    if (model) {
        self = model;
    } else {
        [cache setImageModel:self URL:url];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (IDPImageCache *)cache {
    static IDPImageCache *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [IDPImageCache sharedCache];
    });
    
    return cache;
}

- (NSString *)filePath {
    return [NSFileManager pathWithFileName:self.imageName];
}

#pragma mark -
#pragma mark Public Methods

//- (void)processLoading {
//    IDPWeakify(self)
//    IDPLoadingBlock block = ^id <NSCoding>{
//        IDPStrongify(self)
//        
//        self.state = IDPModelWillLoad;
//        
//        self.image = [self imageWithUrl:self.url];
//        
//        return nil;
//    };
//    
//    IDPCompletionBlock completion = ^(id <NSCoding> result) {
//        IDPStrongify(self)
//        
//        IDPDispatchOnMainQueue(^{
//            self.state = self.image ? IDPModelDidLoad : IDPModelDidFailLoading;
//        });
//    };
//    
//    [self loadWithBlock:block completion:completion];
//}

- (UIImage *)imageWithUrl:(NSURL *)url {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = self.filePath;
    NSData *data;
    UIImage *image = nil;
    
    if ([fileManager fileExistsAtPath:filePath]) {
        data = [NSData dataWithContentsOfFile:filePath];
        
        if (data) {
            image = [UIImage imageWithData:data];
        } else {
            //handle error
        }
    } else {
        data = [[NSData alloc] initWithContentsOfURL:url];
        
        if (data) {
            [data writeToFile:filePath atomically:YES];
        }
        
        image = [UIImage imageWithData:data];
    }
    
    return image;
}

- (void)processLoading  {
    self.state = IDPModelWillLoad;
    
    NSURL *url = [NSURL URLWithString:@"https://img-9gag-fun.9cache.com/photo/aL8PBM5_700b.jpg"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration
                                                backgroundSessionConfigurationWithIdentifier:@"backgroundSession"];
    configuration.timeoutIntervalForResource = 3.0;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration
                                                          delegate:self
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url];
                                      
    [task resume];
}


- (void)dump {
    self.image = nil;
    self.state = IDPModelDidUnload;
}

#pragma mark -
#pragma mark NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSData *data = [NSData dataWithContentsOfURL:location];
    
    if (data) {
        self.image = [UIImage imageWithData:data];
        self.state = IDPModelDidLoad;
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    
}

@end
