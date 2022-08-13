//
//  NewsFeedViewController.m
//  RSSReader
//
//  Created by Kirill on 27.01.22.
//

#import "NewsFeedViewController.h"
#import "NewsFeedCell.h"
#import "ActivityIndicatior.h"
#import "WebViewViewController.h"
#import "UIColor+RSSAppColors.h"
#import "RSSBaseRouter.h"
#import "RSSAlertPresenter.h"
#import "UINavigationController+HideAndShowBars.h"

@interface NewsFeedViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) ActivityIndicatior *activityIndicator;
@property (nonatomic, retain) UIApplication *networkIndicator;
@property (nonatomic, retain) UIRefreshControl *refreshControl;

- (void)setupTableView;
- (void)updateView;
- (void)showAlert:(NSError *)error;

@end

@implementation NewsFeedViewController

@synthesize viewModel = _viewModel;

// MARK: - VC lifcycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.rssBackgroundColor;
    
    [self setupTableView];
    
    // FIXME: - вынести индикатор в отдельный статик в мой активити индикатор

    if (@available(iOS 13.0, *)) {
        self.activityIndicator = [[ActivityIndicatior alloc] initWithView:self.view andStyle:UIActivityIndicatorViewStyleLarge];
    } else {
        self.activityIndicator = [[ActivityIndicatior alloc] initWithView:self.view andStyle:UIActivityIndicatorViewStyleGray];
    }
    
    self.refreshControl = [[[UIRefreshControl alloc] init] autorelease];
    self.refreshControl.tintColor = UIColor.grayColor;
    [self.refreshControl addTarget:self action:@selector(updateView) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    [self.activityIndicator start];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setToolbarAndNavigationBarHidden:YES animated:YES];
    
    [self updateView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.networkIndicator.networkActivityIndicatorVisible = NO;
}

// MARK: - Extension methods

- (void)setupTableView {
    
    UITableView *table = [[[UITableView alloc] initWithFrame:CGRectZero] autorelease];
    table = [[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped] autorelease];
    table.backgroundColor = UIColor.clearColor;
    table.scrollEnabled = true;
    table.dataSource = self;
    table.delegate = self;
    table.rowHeight = UITableViewAutomaticDimension;
    table.delaysContentTouches = NO;
    [table registerClass: NewsFeedCell.class forCellReuseIdentifier:NewsFeedCell.reuseIdentifier];
    
    [self.view addSubview: table];
    table.translatesAutoresizingMaskIntoConstraints = false;
    
    [NSLayoutConstraint activateConstraints: @[
        [table.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [table.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [table.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [table.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
    ]];
    
    self.tableView = table;
}

- (void)updateView {
    __block typeof(self) weakSelf = self;
    
    [self.viewModel updateNewsFeedWithSuccessBlock:^(NSArray<NewsModel *>  * _Nonnull newsModelsArray) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            [weakSelf.activityIndicator stop];
            [weakSelf.refreshControl endRefreshing];
            weakSelf.networkIndicator.networkActivityIndicatorVisible = YES;
        });
    } andFailureBlock:^(NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf showAlert:error];
        });
    }];
}

- (void)showAlert:(NSError *)error {
    __weak typeof(self) weakSelf = self;
    
    UIAlertController *alert = [RSSErrorHandler getAlert:error completion:^{
        [weakSelf.refreshControl endRefreshing];
        [weakSelf.activityIndicator stop];
    }];
    
    [self.navigationController presentViewController:alert animated:YES completion:nil];
        
}

- (void)dealloc {
    [_viewModel release];
    [_tableView release];
    [_networkIndicator release];
    [_refreshControl release];
    [_activityIndicator release];
    [super dealloc];
}

// MARK: - UITableViewDelegate and UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
        NewsFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:[NewsFeedCell reuseIdentifier] forIndexPath:indexPath];
        [cell setupWithModel:self.viewModel.newsModels[indexPath.item]];
        return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.viewModel.newsModels) {
        return self.viewModel.newsModels.count;
    }
    return 0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // handle changes in VM if needed
    [self.viewModel tableViewCellDidPress:indexPath.item];
    
    // show WebView screen
    NSURL *url = [NSURL URLWithString:self.viewModel.newsModels[indexPath.item].link];
    [[RSSBaseRouter sharedRouter] showWebViewWithURL:url];
    [tableView deselectRowAtIndexPath:indexPath animated:true];

}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    // handle changes in VM if needed
    [self.viewModel annotationButtonDidPress:indexPath.item];
    
    // show Details screen
    NewsModel *newsItem = self.viewModel.newsModels[indexPath.item];
    [[RSSBaseRouter sharedRouter] showDetailsViewWithModel:newsItem];
}


@end
