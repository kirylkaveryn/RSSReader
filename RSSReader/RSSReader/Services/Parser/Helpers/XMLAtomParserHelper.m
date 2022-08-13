//
//  XMLAtomParserHelper.m
//  RSSReader
//
//  Created by Kirill on 18.04.22.
//

#import "XMLAtomParserHelper.h"
#import "RSSDateFormatter.h"

@implementation XMLAtomParserHelper

+ (NSString *)itemType {
    return @"entry";
}

- (NSMutableDictionary *)getNewParsingDictionary:(NSString *)elementName {
    if ([elementName isEqualToString:[XMLAtomParserHelper itemType]]) {
        return [[NSMutableDictionary new] autorelease];
    }
    return nil;
}

- (NSMutableString *)getNewParsingString:(NSString *)elementName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    if ([elementName isEqualToString:@"link"]) {
        return [[attributeDict[@"href"] copy] autorelease];
    }
    if ([elementName isEqualToString:[XMLAtomParserHelper itemType]]) {
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
                                                    summary:dictionary[@"summary"]
                                                       date:[RSSDateFormatter getDateFromString:dictionary[@"dc:date"]]];
    [dictionary release];
    return [newsModel autorelease];
}


@end
