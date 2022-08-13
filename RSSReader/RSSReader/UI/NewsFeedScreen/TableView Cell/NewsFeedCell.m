//
//  NewsFeedCell.m
//  RSSReader
//
//  Created by Kirill on 27.01.22.
//

#import "NewsFeedCell.h"
#import "RSSDateFormatter.h"
#import "UIColor+RSSAppColors.h"

@interface NewsFeedCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation NewsFeedCell

+ (NSString *)reuseIdentifier {
    return @"NewsFeedCell";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCellViews];
    };
    return self;
}

- (void)setupCellViews {
    self.backgroundColor = UIColor.rssBackgroundColor;
    self.accessoryType = UITableViewCellAccessoryDetailButton;

    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    self.dateLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    
    [self.titleLabel setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightBold]];
    self.titleLabel.textColor = UIColor.rssMainTextColor;
    [self.titleLabel setNumberOfLines:0];

    
    [self.dateLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium]];
    self.dateLabel.textColor = UIColor.rssSecondaryTextColor;
    [self.dateLabel setNumberOfLines:1];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.dateLabel];
    
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = false;
    
    [NSLayoutConstraint activateConstraints: @[
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:20],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-80],
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:5],
        
        [self.dateLabel.leadingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor],
        [self.dateLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:5],
        [self.dateLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-5]
    ]];
    
}

- (void)setupWithModel:(NewsModel *)model {
    [model retain];
    self.titleLabel.text = model.title;
    if (model.date) {
        self.dateLabel.text = [RSSDateFormatter getDateStringFromDate:model.date style:RSSDateFormatStyleMedium];
    }
    [model release];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
