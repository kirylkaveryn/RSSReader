//
//  RSSDetailsViewController.m
//  RSSReader
//
//  Created by Kirill on 29.03.22.
//

#import "RSSDetailsViewController.h"
#import "RSSDateFormatter.h"
#import "UIColor+RSSAppColors.h"

@interface RSSDetailsViewController () <UIScrollViewDelegate>

@property (nonatomic, retain) id<RSSDetailsViewModelProtocol> viewModel;
@property (nonatomic, retain) UILabel *newsLabel;
@property (nonatomic, retain) UILabel *dataLabel;
@property (nonatomic, retain) UILabel *descriptionLabel;
@property (nonatomic, retain) UIScrollView *scrollView;

- (void)setupScrollView ;
- (void)setupLables;
- (void)activateConstraints;

@end

@implementation RSSDetailsViewController

- (instancetype)initWithViewModel:(id<RSSDetailsViewModelProtocol>)viewModel {
    self = [super init];
    if (self) {
        _viewModel = [viewModel retain];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.rssBackgroundColor;

    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setupScrollView];
    [self setupLables];
    [self activateConstraints];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)dealloc {
    [_viewModel release];
    [_newsLabel release];
    [_dataLabel release];
    [_descriptionLabel release];
    [_scrollView release];
    [super dealloc];
}

// MARK: - Private methods

- (void)setupScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    
    self.scrollView = scrollView;
}

- (void)setupLables {
    UILabel *newsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    UILabel *dataLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    newsLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightBold];
    dataLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    descriptionLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
        
    newsLabel.textColor = UIColor.rssMainTextColor;
    dataLabel.textColor = UIColor.rssSecondaryTextColor;
    descriptionLabel.textColor = UIColor.rssSecondaryTextColor;
    
    newsLabel.numberOfLines = 0;
    dataLabel.numberOfLines = 0;
    descriptionLabel.numberOfLines = 0;

    newsLabel.text = self.viewModel.title;
    dataLabel.text = [RSSDateFormatter getDateStringFromDate:self.viewModel.date style:RSSDateFormatStyleMedium];
    descriptionLabel.text = self.viewModel.summary;
    
    self.newsLabel = newsLabel;
    self.dataLabel = dataLabel;
    self.descriptionLabel = descriptionLabel;
    
}

- (void)activateConstraints {
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.newsLabel];
    [self.scrollView addSubview:self.dataLabel];
    [self.scrollView addSubview:self.descriptionLabel];
    
    self.scrollView.translatesAutoresizingMaskIntoConstraints = false;
    self.newsLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.dataLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.frameLayoutGuide.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.scrollView.frameLayoutGuide.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [self.scrollView.frameLayoutGuide.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.scrollView.frameLayoutGuide.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        
        [self.scrollView.contentLayoutGuide.leadingAnchor constraintEqualToAnchor:self.scrollView.frameLayoutGuide.leadingAnchor],
        [self.scrollView.contentLayoutGuide.trailingAnchor constraintEqualToAnchor:self.scrollView.frameLayoutGuide.trailingAnchor],
        [self.scrollView.contentLayoutGuide.topAnchor constraintEqualToAnchor:self.scrollView.frameLayoutGuide.topAnchor],
        
        [self.newsLabel.leadingAnchor constraintEqualToAnchor:self.scrollView.contentLayoutGuide.leadingAnchor constant:20],
        [self.newsLabel.trailingAnchor constraintEqualToAnchor:self.scrollView.contentLayoutGuide.trailingAnchor constant:-20],
        [self.newsLabel.topAnchor constraintEqualToAnchor:self.scrollView.contentLayoutGuide.topAnchor constant:20],
        
        [self.dataLabel.leadingAnchor constraintEqualToAnchor:self.newsLabel.leadingAnchor],
        [self.dataLabel.trailingAnchor constraintEqualToAnchor:self.newsLabel.trailingAnchor],
        [self.dataLabel.topAnchor constraintEqualToAnchor:self.newsLabel.bottomAnchor constant:20],
        
        [self.descriptionLabel.leadingAnchor constraintEqualToAnchor:self.newsLabel.leadingAnchor],
        [self.descriptionLabel.trailingAnchor constraintEqualToAnchor:self.newsLabel.trailingAnchor],
        [self.descriptionLabel.topAnchor constraintEqualToAnchor:self.dataLabel.bottomAnchor constant:20],
        
        [self.descriptionLabel.bottomAnchor constraintEqualToAnchor:self.scrollView.contentLayoutGuide.bottomAnchor constant:-20],
    ]];
    
}


@end
