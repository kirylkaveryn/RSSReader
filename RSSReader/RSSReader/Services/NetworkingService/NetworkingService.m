//
//  NetworkingService.m
//  RSSReader
//
//  Created by Kirill on 28.01.22.
//

#import "NetworkingService.h"
#import "NewsModel.h"
#import "XMLParser.h"
#import "RSSLoader.h"
#import "RSSError.h"

@interface NetworkingService ()

@end

@implementation NetworkingService

@synthesize parser = _parser;
@synthesize loader = _loader;

- (instancetype)initWithParser:(id<ParserProtocol>)parser andLoader:(id<RSSLoaderProtocol>)loader {
    self = [super init];
    if (self) {
        _parser = [parser retain];
        _loader = [loader retain];
    }
    return self;
}

- (void)loadFeedFromURL:(NSString *)stringURL completion:(void (^)(NSArray<NewsModel *> *, NSError *))completion {
    NSURL *url = [NSURL URLWithString:stringURL];
    
    __block typeof(self) weakSelf = self;
    NSThread *thread = [[[NSThread alloc] initWithBlock:^{
//        sleep(.5);
        
        NSError *error = nil;
        NSData *data = [weakSelf.loader getDataWithURL:url error:&error];

        if (error) {
            completion(nil, [RSSError errorWithReason:NetworkingErrorNoInternetConnection]);
            return;
        }
        
        [weakSelf.parser parseModels:data completion:completion];
        
    }] autorelease];
    thread.qualityOfService = NSQualityOfServiceUtility;
    
    [thread start];
    
}

- (void)dealloc {
    [_parser release];
    [_loader release];
    [super dealloc];
}

@end
