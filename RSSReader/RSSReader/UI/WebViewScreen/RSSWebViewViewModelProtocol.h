//
//  RSSWebViewViewModelProtocol.h
//  RSSReader
//
//  Created by Kirill on 22.04.22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RSSWebViewViewModelProtocol <NSObject>

@property (nonatomic, copy) NSURL *url;

- (void)setUrl:(NSURL *)url withCompletion:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
