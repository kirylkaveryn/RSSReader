//
//  RSSAlertPresenter.m
//  RSSReader
//
//  Created by Kirill on 10.02.22.
//

#import "RSSAlertPresenter.h"

@implementation RSSAlertPresenter

+ (UIAlertController *)getErrorAlert:(NSError *)error completion:(CompletionBlock)completion {
    UIAlertController *alert = [[UIAlertController alertControllerWithTitle:nil message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert] autorelease];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:completion];
    }];
    [alert addAction:action];
    return alert;
}

@end

