//
//  NetworkingServiceProtocol.h
//  RSSReader
//
//  Created by Kirill on 28.01.22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ParserProtocol;
@protocol RSSLoaderProtocol;
@class NewsModel;

@protocol NetworkingServiceProtocol <NSObject>

@property (nonatomic, retain) id<ParserProtocol> parser;
@property (nonatomic, retain) id<RSSLoaderProtocol> loader;

- (instancetype)initWithParser:(id<ParserProtocol>)parser andLoader:(id<RSSLoaderProtocol>)loader;
- (void)loadFeedFromURL:(NSString *)stringURL completion:(void (^)(NSArray<NewsModel *> *, NSError *))completion;

@end

NS_ASSUME_NONNULL_END
