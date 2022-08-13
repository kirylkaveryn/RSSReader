//
//  RSSError.h
//  RSSReader
//
//  Created by Kirill on 16.02.22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, NetworkingErrorCode) {
    NetworkingErrorNoInternetConnection,
    NetworkingErrorFeedIsUnavailable,
    NetworkingErrorCorruptedData,
    NetworkingErrorUncompleteData,
};

@interface RSSError : NSObject

+ (NSError *)errorWithReason:(NetworkingErrorCode)networkingErrorCode;

@end

NS_ASSUME_NONNULL_END
