//
//  RSSToastMessagePresenter.h
//  RSSReader
//
//  Created by Kirill on 21.04.22.
//

#import <Foundation/Foundation.h>
#import "RSSErrorHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSToastMessagePresenter : NSObject

+ (UIAlertController *)getToastMessage:(NSString *)message seconds:(float)seconds completion:(CompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
