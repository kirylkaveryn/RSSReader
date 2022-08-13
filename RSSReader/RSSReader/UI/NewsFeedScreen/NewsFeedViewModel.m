//
//  NewsFeedViewModel.m
//  RSSReader
//
//  Created by Kirill on 27.01.22.
//

#import <UIKit/UIKit.h>
#import "NewsFeedViewModel.h"
#import "NetworkingServiceProtocol.h"

@class RSSError;

@interface NewsFeedViewModel ()

@property (nonatomic, retain) id<NetworkingServiceProtocol> networkingService;
@property (nonatomic, retain) WebViewViewController *webViewVC;

@end

@implementation NewsFeedViewModel

@synthesize newsModels = _newsModels;
@synthesize networkingService = _networkingService;

- (instancetype)initWithNetworkingService:(id<NetworkingServiceProtocol>) networkingService {
    self = [super init];
    if (self) {
        [networkingService retain];
        _newsModels = [[NSArray alloc] init];
        _networkingService = networkingService;
    }
    return self;
}

- (void)updateNewsFeedWithSuccessBlock:(void (^)(NSArray<NewsModel *> *))success
                       andFailureBlock:(void (^)(NSError*))failure {
    //    NSString *stringURL = @"https://www.raywenderlich.com/feed";
    NSString *stringURL = @"https://www.jpl.nasa.gov/feeds/news";
//        NSString *stringURL = @"https://www.jp.nasa.gov/feeds/news"; // bad URL
    //    NSString *stringURL = @"https://developer.apple.com/news/rss/news.rss";
    
    __block typeof(self) weakSelf = self;
    [weakSelf.networkingService loadFeedFromURL:stringURL completion:^(NSArray<NewsModel *> *data, NSError *error) {
        if (error && !data) {
            failure(error);
        } else if (data) {
            weakSelf.newsModels = [[data copy] autorelease];
            success(weakSelf.newsModels);
            if (error) {
                // if some additonal error happens
                failure(error);
            }
        }
    }];
}

- (void)tableViewCellDidPress:(NSInteger)cellIndex {
    // make some changes if needed
}

- (void)annotationButtonDidPress:(NSInteger)cellIndex {
    // make some changes if needed
}


- (void)dealloc {
    [_newsModels release];
    [super dealloc];
}

@end
