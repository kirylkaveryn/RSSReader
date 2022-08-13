//
//  WebViewViewController.h
//  RSSReader
//
//  Created by Kirill on 28.03.22.
//

#import <UIKit/UIKit.h>
#import "RSSWebViewViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RSSWebViewViewModelProtocol;

@interface WebViewViewController : UIViewController

@property (nonatomic, retain) id<RSSWebViewViewModelProtocol> viewModel;

- (instancetype)initWithViewModel:(id<RSSWebViewViewModelProtocol>)viewModel;
- (void)updateWebView;

@end

NS_ASSUME_NONNULL_END
