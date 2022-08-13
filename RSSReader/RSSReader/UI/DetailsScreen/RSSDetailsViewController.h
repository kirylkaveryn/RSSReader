//
//  RSSDetailsViewController.h
//  RSSReader
//
//  Created by Kirill on 29.03.22.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "RSSDetailsViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSDetailsViewController : UIViewController

- (instancetype)initWithViewModel:(id<RSSDetailsViewModelProtocol>)viewModel;

@end

NS_ASSUME_NONNULL_END
