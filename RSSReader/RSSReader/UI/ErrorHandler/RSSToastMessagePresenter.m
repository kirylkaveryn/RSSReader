//
//  RSSToastMessagePresenter.m
//  RSSReader
//
//  Created by Kirill on 21.04.22.
//

#import "RSSToastMessagePresenter.h"

@implementation RSSToastMessagePresenter

+ (UIAlertController *)getToastMessage:(NSString *)message seconds:(float)seconds completion:(CompletionBlock)completion {
    NSString *messageString = [message copy];
    UIAlertController *alert = [[UIAlertController alertControllerWithTitle:nil message:messageString preferredStyle:UIAlertControllerStyleAlert] autorelease];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:completion];
    });
    
    return alert;
}

@end
