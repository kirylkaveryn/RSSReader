//
//  RSSBaseRouterProtocol.h
//  RSSReader
//
//  Created by Kirill on 18.04.22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class NewsModel, NewsFeedViewController;

@protocol RSSRouterProtocol <NSObject>

@property (nonatomic, assign) UINavigationController *navigationController;

+ (instancetype)sharedRouter;
- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;
- (void)showWebViewWithURL:(NSURL *)url;
- (void)showDetailsViewWithModel:(NewsModel *)newsModel;

@end

NS_ASSUME_NONNULL_END
