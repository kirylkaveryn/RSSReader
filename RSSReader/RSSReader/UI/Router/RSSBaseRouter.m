//
//  RSSBaseRouter.m
//  RSSReader
//
//  Created by Kirill on 29.03.22.
//

#import "RSSBaseRouter.h"
#import "RSSDetailsViewController.h"
#import "RSSWebViewViewModel.h"
#import "RSSDetailsViewModel.h"

@interface RSSBaseRouter ()

@property (nonatomic, assign) id<RSSWebViewViewModelProtocol> webViewModel;
@property (nonatomic, retain) WebViewViewController *webViewViewController;

@end


@implementation RSSBaseRouter

@synthesize navigationController = _navigationController;

// FIXME: - спросить у Жени можно ли делать такой шарэд инстанс для роутера
+ (instancetype)sharedRouter {
    static RSSBaseRouter *_sharedRouter = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_sharedRouter) {
            UINavigationController *currentNavigationVC = (UINavigationController*)[UIApplication sharedApplication].delegate.window.rootViewController;
            if (currentNavigationVC && [currentNavigationVC isMemberOfClass:UINavigationController.class]) {
                _sharedRouter = [[RSSBaseRouter alloc] initWithNavigationController:currentNavigationVC];
            }
        }
    });
    return _sharedRouter;
}

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController {
    self = [super init];
    if (self) {
        _navigationController = navigationController;
        return self;
    };
    return nil;
}

- (void)showWebViewWithURL:(NSURL *)url {
    __block typeof(self) weakSelf = self;
    if (!_webViewViewController) {
        weakSelf.webViewModel = [[RSSWebViewViewModel new] autorelease];
        weakSelf.webViewViewController = [[WebViewViewController new] autorelease];
        weakSelf.webViewViewController.viewModel = weakSelf.webViewModel;
    }
    // FIXME: - bad completion in Router!

    [weakSelf.webViewModel setUrl:url withCompletion:^{
        [weakSelf.webViewViewController updateWebView];
    }];
    
    [self.navigationController pushViewController:self.webViewViewController animated:YES];
}

- (void)showDetailsViewWithModel:(NewsModel *)newsModel {
    RSSDetailsViewModel *viewModel = [[[RSSDetailsViewModel alloc] initWithNewsModel:newsModel] autorelease];
    RSSDetailsViewController *detailsViewController = [[[RSSDetailsViewController alloc] initWithViewModel:viewModel] autorelease];
    [self.navigationController pushViewController:detailsViewController animated:YES];
}

- (void)dealloc {
    [_navigationController release];
    [_webViewViewController release];
    [_webViewModel release];
    _webViewModel = nil;
    [super dealloc];
}

@end
