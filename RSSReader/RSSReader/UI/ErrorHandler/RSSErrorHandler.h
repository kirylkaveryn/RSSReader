//
//  RSSErrorHandler.h
//  RSSReader
//
//  Created by Kirill on 21.04.22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CompletionBlock)(void);

@interface RSSErrorHandler : NSObject

+ (UIAlertController *)getAlert:(NSError *)error completion:(CompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
