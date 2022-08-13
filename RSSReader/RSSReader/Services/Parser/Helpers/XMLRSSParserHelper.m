//
//  XMLRSSParserHelper.m
//  RSSReader
//
//  Created by Kirill on 18.04.22.
//

#import "XMLRSSParserHelper.h"
#import "RSSDateFormatter.h"

@implementation XMLRSSParserHelper

+ (NSString *)itemType {
    return @"item";
}

- (NSMutableDictionary *)getNewParsingDictionary:(NSString *)elementName {
    if ([elementName isEqualToString:[XMLRSSParserHelper itemType]]) {
        return [[NSMutableDictionary new] autorelease];
    }
    return nil;
}

- (NSMutableString *)getNewParsingString:(NSString *)elementName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    if ([elementName isEqualToString:[XMLRSSParserHelper itemType]]) {
        return nil;
    }
    return [[NSMutableString new] autorelease];
}

- (NewsModel *)getNewsModel:(NSDictionary *)dictionary {
    [dictionary retain];
    if (!dictionary) {
        return nil;
    }
    NewsModel *newsModel = [[NewsModel alloc] initWithTitle:dictionary[@"title"]
                                                        link:dictionary[@"link"]
                                                     summary:dictionary[@"description"]
                                                        date:[RSSDateFormatter getDateFromString:dictionary[@"pubDate"]]] ;

    [dictionary release];
    return [newsModel autorelease];
}


@end
