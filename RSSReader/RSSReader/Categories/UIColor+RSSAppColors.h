//
//  UIColor+UIColor_RSSAppColors.h
//  RSSReader
//
//  Created by Kirill on 5.04.22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (RSSAppColors)

@property (class, nonatomic, readonly) UIColor *rssBackgroundColor;
@property (class, nonatomic, readonly) UIColor *rssMainTextColor;
@property (class, nonatomic, readonly) UIColor *rssSecondaryTextColor;

@end

NS_ASSUME_NONNULL_END
