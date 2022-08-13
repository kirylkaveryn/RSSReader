//
//  RSSWebViewViewModel.m
//  RSSReader
//
//  Created by Kirill on 22.04.22.
//

#import "RSSWebViewViewModel.h"

@interface RSSWebViewViewModel()

@end

@implementation RSSWebViewViewModel

@synthesize url = _url;

- (void)setUrl:(NSURL *)url withCompletion:(void (^)(void))completion {
    self.url = url;
    completion();
}

@end
