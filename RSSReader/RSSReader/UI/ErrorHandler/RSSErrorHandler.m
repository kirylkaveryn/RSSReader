//
//  RSSErrorHandler.m
//  RSSReader
//
//  Created by Kirill on 21.04.22.
//

#import "RSSErrorHandler.h"
#import "RSSAlertPresenter.h"
#import "RSSToastMessagePresenter.h"

@implementation RSSErrorHandler

+ (UIAlertController *)getAlert:(NSError *)error completion:(CompletionBlock)completion {
    if (error.localizedRecoveryOptions) {
        return [RSSAlertPresenter getErrorAlert:error completion:completion];
    } else {
        return [RSSToastMessagePresenter getToastMessage:error.localizedDescription seconds:2.5 completion:completion];
    }
}


@end
