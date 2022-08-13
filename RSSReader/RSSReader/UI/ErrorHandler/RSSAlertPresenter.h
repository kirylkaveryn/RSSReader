//
//  RSSAlertPresenter.h
//  RSSReader
//
//  Created by Kirill on 10.02.22.
//

#import <Foundation/Foundation.h>
#import "RSSErrorHandler.h"

NS_ASSUME_NONNULL_BEGIN


@interface RSSAlertPresenter : NSObject

+ (UIAlertController *)getErrorAlert:(NSError *)error completion:(CompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
