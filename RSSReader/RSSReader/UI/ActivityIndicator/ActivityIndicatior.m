//
//  ActivityIndicatior.m
//  RSSReader
//
//  Created by Kirill on 9.02.22.
//

#import "ActivityIndicatior.h"

@interface ActivityIndicatior ()

@property (nonatomic, retain) UIView *view;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

@end

@implementation ActivityIndicatior

//+ (instancetype)sharedActivityIndicator {
//    static ActivityIndicatior *_activityIndicator = nil;
//
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        UIView *view
//        _activityIndicator = [ActivityIndicatior alloc] initWithView:<#(nonnull UIView *)#> andStyle:UIActivityIndicatorViewStyleLarge
//    });
//    return _activityIndicator;
//}

- (instancetype)initWithView:(UIView *)view andStyle:(UIActivityIndicatorViewStyle)style {
    self = [super init];
    if (self) {
        [view retain];
        if (view) {
            _view = view;
        } else {
            _view = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        }
        
        if (@available(iOS 12.4, *)) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
        
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
        _activityIndicator.color = UIColor.grayColor;
    }
    return self;
}

- (void)start {
    self.activityIndicator.center = self.view.center;
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
}

- (void)stop {
    [self.activityIndicator stopAnimating];
    [self.activityIndicator removeFromSuperview];
}

- (void)dealloc {
    [_view release];
    [_activityIndicator release];
    [super dealloc];
}
@end
