//
//  NewsFeedCell.h
//  RSSReader
//
//  Created by Kirill on 27.01.22.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsFeedCell : UITableViewCell

@property (class, copy, readonly) NSString *reuseIdentifier;
- (void)setupWithModel:(NewsModel *)model;

@end

NS_ASSUME_NONNULL_END
