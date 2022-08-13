//
//  RSSLoaderProtocol.h
//  RSSReader
//
//  Created by Kirill on 26.04.22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RSSLoaderProtocol <NSObject>

- (NSData *)getDataWithURL:(NSURL *)url error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
