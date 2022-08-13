//
//  XMLParserHelper.m
//  RSSReader
//
//  Created by Kirill on 25.04.22.
//

#import "XMLParserHelper.h"
#import "XMLRSSParserHelper.h"
#import "XMLAtomParserHelper.h"

@implementation XMLParserHelper

+ (id<XMLParserHelperProtocol>)helperWithXMLFormat:(RSSXMLFormat)format {
    switch (format) {
        case XMLAtom:
            return [[XMLAtomParserHelper new] autorelease];
            break;
        case XMLRSS:
            return [[XMLRSSParserHelper new] autorelease];
            break;
    }
}

// primitive methods to subclass

+ (NSString *)itemType {
    return nil;
}

- (NSMutableDictionary *)getNewParsingDictionary:(NSString *)elementName {
    return nil;
}

- (NSMutableString *)getNewParsingString:(NSString *)elementName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    return nil;
}

- (NewsModel *)getNewsModel:(NSDictionary *)dictionary {
    return nil;
}

@end
