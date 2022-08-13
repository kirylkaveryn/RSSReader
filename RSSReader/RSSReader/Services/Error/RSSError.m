//
//  RSSError.m
//  RSSReader
//
//  Created by Kirill on 16.02.22.
//

#import "RSSError.h"

static NSString *domain;

@interface RSSError ()

@end

@implementation RSSError

+ (void)initialize {
    if (self == [RSSError class]) {
        domain = @"com.Lab.RSSReader";
    }
}

+ (NSError *)errorWithReason:(NetworkingErrorCode)networkingErrorCode {
    
    NSDictionary *userInfo;
    
    switch (networkingErrorCode) {
        case NetworkingErrorNoInternetConnection:
            userInfo = @{
                NSLocalizedDescriptionKey: @"Something went wrong.\nPlease check your internet connection or URL and swipe down to refresh feed.",
                NSLocalizedRecoveryOptionsErrorKey: @[@"OK"]
            };
            break;
        case  NetworkingErrorFeedIsUnavailable:
            userInfo = @{
                NSLocalizedDescriptionKey: @"RSS Feed is unavailable.",
            };
            break;
        case NetworkingErrorCorruptedData:
            userInfo = @{
                NSLocalizedDescriptionKey: @"RSS data is corrupted.",
            };
            break;
        case NetworkingErrorUncompleteData:
            userInfo = @{
                NSLocalizedDescriptionKey: @"Some data was missed. Please, check source URL and refresh feed.",
            };
            break;
    }
    
    NSError *error = [[NSError alloc] initWithDomain:domain code:networkingErrorCode userInfo:userInfo];
    return [error autorelease];
}

@end
