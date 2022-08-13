//
//  ParserProtocol.h
//  RSSReader
//
//  Created by Kirill on 28.01.22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class NewsModel;

@protocol ParserProtocol <NSObject>

- (void)parseModels:(NSData *)data completion:(void(^)(NSArray<NewsModel *> *, NSError *))completion;

@end

NS_ASSUME_NONNULL_END
