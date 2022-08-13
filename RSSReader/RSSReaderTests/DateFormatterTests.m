//
//  DateFormatterTests.m
//
//
//  Created by Kirill on 27.01.22.
//

#import <XCTest/XCTest.h>

@interface RSSReaderTests : XCTestCase

@end

@implementation RSSReaderTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testDateFormatter {
    NSString *inputStringDate = @"Mon, 07 Feb 2022 00:00:00 -0800";
    NSDateFormatter *inputFormatter = [NSDateFormatter new];
//    inputFormatter.dateFormat = @"E, d MMM yyyy HH:mm:ss Z";
    
    NSArray *dateFormatsArray = [NSArray arrayWithObjects: @"yyyy-MM-dd'T'HH:mm:ssZ", @"E, d MMM yyyy HH:mm:ss Z", @"EEEE, MMM d, yyyy", @"MM/dd/yyyy", @"MM-dd-yyyy HH:mm", @"MMM d, h:mm a", @"MMMM yyyy", @"MMM d, yyyy", @"dd.MM.yy", @"HH:mm:ss.SSS", nil];
    
    NSDate *date = nil;
    NSUInteger i = 0;
    while (!date && i < dateFormatsArray.count) {
        inputFormatter.dateFormat = dateFormatsArray[i];
        date = [inputFormatter dateFromString:inputStringDate];
        i += 1;
    }
    
    NSDateFormatter *outputFormatter = [NSDateFormatter new];
    outputFormatter.dateStyle = NSDateFormatterMediumStyle;
    outputFormatter.timeStyle = NSDateFormatterNoStyle;
    outputFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    outputFormatter.timeZone = [NSTimeZone localTimeZone];
    NSLog(@"%@", [outputFormatter stringFromDate:date]);
}

@end
