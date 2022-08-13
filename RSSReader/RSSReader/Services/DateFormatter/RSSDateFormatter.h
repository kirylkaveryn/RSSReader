//
//  RSSDateFormatter.h
//  RSSReader
//
//  Created by Kirill on 17.03.22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, RSSDateFormatStyle) {
    RSSDateFormatStyleFull,
    RSSDateFormatStyleMedium,
    RSSDateFormatStyleCompact,
    RSSDateFormatStyleOnlyDate,
    RSSDateFormatStyleOnlyTime,
};

@interface RSSDateFormatter : NSObject

+ (nonnull NSString *)getDateStringFromString:(NSString *)inputDateString style:(RSSDateFormatStyle)style;
+ (NSDate *)getDateFromString:(NSString *)inputDateString;
+ (nonnull NSString *)getDateStringFromDate:(NSDate *)date style:(RSSDateFormatStyle)style;

@end

NS_ASSUME_NONNULL_END
