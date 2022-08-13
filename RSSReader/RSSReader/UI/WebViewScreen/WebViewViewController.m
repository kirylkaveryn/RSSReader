//
//  WebViewViewController.m
//  RSSReader
//
//  Created by Kirill on 28.03.22.
//

#import "WebViewViewController.h"
#import <WebKit/WebKit.h>
#import "UINavigationController+HideAndShowBars.h"

static void *WebViewViewContext = &WebViewViewContext;

@interface WebViewViewController () <WKNavigationDelegate>

@property (nonatomic, retain) WKWebView *webView;
@property (nonatomic, copy) NSURL *webURL;
@property (nonatomic, retain) UIBarButtonItem *flexibleSpaceItem;
@property (nonatomic, retain) UIBarButtonItem *fixedSpaceItem;
@property (nonatomic, retain) UIBarButtonItem *goBackButton;
@property (nonatomic, retain) UIBarButtonItem *goForwardButton;
@property (nonatomic, retain) UIBarButtonItem *shareButton;
@property (nonatomic, retain) UIBarButtonItem *safariButton ;
@property (nonatomic, retain) UIBarButtonItem *reloadButtonItem;
@property (nonatomic, retain) UIBarButtonItem *stopButtonItem;

- (void)setupWebView;
- (void)setupButtons;

@end

@implementation WebViewViewController

- (instancetype)initWithViewModel:(id<RSSWebViewViewModelProtocol>)viewModel {
    self = [super init];
    if (self) {
        _viewModel = [viewModel retain];
    };
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupButtons];
    [self setupWebView];
    
    [self updateWebView];
}

- (void)updateWebView {
    [self loadPageWithURL:self.viewModel.url];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
        
    [self.navigationController setToolbarAndNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarAndNavigationBarHidden:YES animated:NO];
}

- (void)setupButtons {
    self.flexibleSpaceItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
    self.fixedSpaceItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil] autorelease];
    self.goBackButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"chevron.left"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackButtonDidPress)] autorelease];
    self.goForwardButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"chevron.right"] style:UIBarButtonItemStylePlain target:self action:@selector(goForwardButtonDidPress)] autorelease];
    self.shareButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"square.and.arrow.up"] style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonDidPress)] autorelease];
    self.safariButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"safari"] style:UIBarButtonItemStylePlain target:self action:@selector(safariButtonDidPress)] autorelease];
    self.reloadButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow.clockwise"] style:UIBarButtonItemStylePlain target:self action:@selector(reloadButtonDidPress)] autorelease];
    self.stopButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopButtonDidPress)] autorelease];
}

- (void)setupWebView {
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.webView = [[[WKWebView alloc] init] autorelease];
    self.webView.backgroundColor = UIColor.whiteColor;
    
    self.view = self.webView;
    
    self.navigationItem.rightBarButtonItem = self.reloadButtonItem;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : UIColor.whiteColor, NSFontAttributeName : [UIFont systemFontOfSize:24]};
    
    self.navigationController.toolbar.tintColor = UIColor.systemBlueColor;
    
    self.fixedSpaceItem.width = 20;
    
    self.goBackButton.enabled = NO;
    self.goForwardButton.enabled = NO;
    self.shareButton.enabled = YES;
    self.safariButton.enabled = YES;
    
    self.webView.navigationDelegate = self;
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:WebViewViewContext];
    [self.webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:WebViewViewContext];
    [self.webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:WebViewViewContext];
    
    [self setToolbarItems: @[
        self.fixedSpaceItem,
        self.goBackButton,
        self.flexibleSpaceItem,
        self.goForwardButton,
        self.flexibleSpaceItem,
        self.shareButton,
        self.flexibleSpaceItem,
        self.safariButton,
        self.fixedSpaceItem
    ] animated:YES];
}


// MARK: - Public non-init methods
- (void)loadPageWithURL:(NSURL *)url {
//    self.webView bac
    self.webURL = url;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    if (request) {
        [self.webView loadRequest:request];
    } else {
        // handle error with request
    }
}


// MARK: - Button Actions

- (void)goBackButtonDidPress {
    [self.webView goBack];
}

- (void)goForwardButtonDidPress {
    [self.webView goForward];
}

- (void)shareButtonDidPress {
    NSURL *url = [self.webURL copy];
    if (self.webURL) {
        UIActivityViewController *activityVC = [[[UIActivityViewController alloc] initWithActivityItems:@[url] applicationActivities:nil] autorelease];
        [self presentViewController:activityVC animated:YES completion:^{
            puts("ActivityViewController is presented");
        }];
    }
}

- (void)safariButtonDidPress {
    UIApplication *application = [UIApplication sharedApplication];
    if (self.webURL) {
        [application openURL:self.webURL options:@{} completionHandler:^(BOOL success) {
                if (success) {
                    // some completion code
                };
        }];
    }
}

- (void)reloadButtonDidPress {
    [self.webView reload];
}

- (void)stopButtonDidPress {
    [self.webView stopLoading];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == WebViewViewContext) {
        if ([keyPath isEqualToString: @"canGoBack"] || [keyPath isEqualToString: @"canGoForward"])  {
            self.goBackButton.enabled = self.webView.canGoBack;
            self.goForwardButton.enabled = self.webView.canGoForward;
        }
        
        if ([keyPath isEqualToString: @"loading"])  {
            BOOL loading = [[change valueForKey:NSKeyValueChangeNewKey] boolValue];
            self.navigationItem.rightBarButtonItem = !loading ? self.reloadButtonItem : self.stopButtonItem;

        }
    }
}

- (void)dealloc {
    [_webView release];
    [_flexibleSpaceItem release];
    [_fixedSpaceItem release];
    [_goBackButton release];
    [_goForwardButton release];
    [_shareButton release];
    [_safariButton release];
    [_reloadButtonItem release];
    [_stopButtonItem release];
    [_webURL release];
    [super dealloc];
}


@end
