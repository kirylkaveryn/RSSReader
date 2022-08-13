//
//  UIColor+UIColor_RSSAppColors.m
//  RSSReader
//
//  Created by Kirill on 5.04.22.
//

#import "UIColor+RSSAppColors.h"

@implementation UIColor (RSSAppColors)

+ (UIColor *)rssBackgroundColor {
    return [UIColor colorNamed:@"BackgroundColor"];
}

+ (UIColor *)rssMainTextColor {
    return [UIColor colorNamed:@"MainTextColor"];
}

+ (UIColor *)rssSecondaryTextColor {
    return [UIColor colorNamed:@"SecondaryTextColor"];
}

@end
