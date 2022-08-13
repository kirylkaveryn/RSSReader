//
//  XMLParserHelper.h
//  RSSReader
//
//  Created by Kirill on 25.04.22.
//

#import <Foundation/Foundation.h>
#import "XMLParserHelperProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, RSSXMLFormat) {
    XMLRSS,
    XMLAtom,
};
 
/// XMLParserHelper is a cluster-class. You should subclass this class and override primitive methods.
///
/// Methods to override: -getNewParsingDictionary,
/// -getNewParsingString:,
/// -getNewsModel:,
/// +itemType

@interface XMLParserHelper : NSObject <XMLParserHelperProtocol>

+ (instancetype)helperWithXMLFormat:(RSSXMLFormat)format;

@end

NS_ASSUME_NONNULL_END
