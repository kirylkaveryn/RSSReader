//
//  RSSDateFormatter.m
//  RSSReader
//
//  Created by Kirill on 17.03.22.
//

#import "RSSDateFormatter.h"

@interface RSSDateFormatter ()

@end

@implementation RSSDateFormatter

static NSArray *dateFormatsArray;
static NSDateFormatter *formatter;

+ (void)initialize {
    if (self == [RSSDateFormatter class]) {
        dateFormatsArray = [[NSArray alloc] initWithObjects: @"yyyy-MM-dd'T'HH:mm:ssZ", @"YYYY-MM-dd'T'HH:mm:ss'Z'", @"E, d MMM yyyy HH:mm:ss Z", @"EEEE, MMM d, yyyy", @"MM/dd/yyyy", @"MM-dd-yyyy HH:mm", @"MMM d, h:mm a", @"MMMM yyyy", @"MMM d, yyyy", @"dd.MM.yy", @"HH:mm:ss.SSS", nil];
        formatter = [NSDateFormatter new];
        formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.timeZone = [NSTimeZone localTimeZone];
    }
}

+ (nonnull NSString *)getDateStringFromString:(NSString *)inputDateString style:(RSSDateFormatStyle)style {
    NSDate *date = [self getDateFromString:inputDateString];

    if (!date) {
        return @"";
    }

    return [RSSDateFormatter getDateStringFromDate:date style:style];
}

+ (NSDate *)getDateFromString:(NSString *)inputDateString {
    NSDate *date = nil;
    NSUInteger i = 0;
    
    while (!date && i < dateFormatsArray.count) {
        formatter.dateFormat = dateFormatsArray[i];
        date = [formatter dateFromString:inputDateString];
        i += 1;
    }
    return date;
}

+ (nonnull NSString *)getDateStringFromDate:(NSDate *)date style:(RSSDateFormatStyle)style {
    [[date retain] autorelease];
    [RSSDateFormatter setupFormatterStyle:style];
    return [formatter stringFromDate:date];
}

+ (void)setupFormatterStyle:(RSSDateFormatStyle)style {
    switch (style) {
        case RSSDateFormatStyleFull:
            formatter.dateStyle = NSDateFormatterFullStyle;
            formatter.timeStyle = NSDateFormatterFullStyle;
            break;
        case RSSDateFormatStyleMedium:
            formatter.dateStyle = NSDateFormatterMediumStyle;
            formatter.timeStyle = NSDateFormatterMediumStyle;
            break;
        case RSSDateFormatStyleCompact:
            formatter.dateStyle = NSDateFormatterShortStyle;
            formatter.timeStyle = NSDateFormatterShortStyle;
            break;
        case RSSDateFormatStyleOnlyDate:
            formatter.dateStyle = NSDateFormatterShortStyle;
            formatter.timeStyle = NSDateFormatterNoStyle;
            break;
        case RSSDateFormatStyleOnlyTime:
            formatter.dateStyle = NSDateFormatterNoStyle;
            formatter.timeStyle = NSDateFormatterMediumStyle;
            break;
    }
}

@end
