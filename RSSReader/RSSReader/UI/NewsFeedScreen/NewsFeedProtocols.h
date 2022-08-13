//
//  NewsFeedViewModelProtocol.h
//  RSSReader
//
//  Created by Kirill on 27.01.22.
//

@class NewsFeedViewController;

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NetworkingServiceProtocol.h"
#import "NewsModel.h"
#import "RSSBaseRouter.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NewsFeedViewControllerProtocol;
@protocol NewsFeedViewModelProtocol;
@class RSSError;


@protocol NewsFeedViewModelProtocol <NSObject>

@property (nonatomic, retain) NSArray<NewsModel *> *newsModels;

- (instancetype)initWithNetworkingService:(id<NetworkingServiceProtocol>)networkingService;
- (void)updateNewsFeedWithSuccessBlock:(void (^)(NSArray<NewsModel *> *))success
                       andFailureBlock:(void (^)(NSError*))failure;
- (void)tableViewCellDidPress:(NSInteger)cellIndex;
- (void)annotationButtonDidPress:(NSInteger)cellIndex;

@end

@protocol NewsFeedViewControllerProtocol <NSObject>

@property (nonatomic, retain) id<NewsFeedViewModelProtocol> viewModel;

@end

NS_ASSUME_NONNULL_END

