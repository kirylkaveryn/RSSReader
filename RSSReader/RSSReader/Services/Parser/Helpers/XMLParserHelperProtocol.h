//
//  XMLParserHelperProtocol.h
//  RSSReader
//
//  Created by Kirill on 18.04.22.
//

#import <Foundation/Foundation.h>
#import "NewsModel.h"

//NS_ASSUME_NONNULL_BEGIN


@protocol XMLParserHelperProtocol <NSObject>

@property (class, nonatomic, readonly) NSString *itemType;

- (NSMutableDictionary *)getNewParsingDictionary:(NSString *)elementName;
- (NSMutableString *)getNewParsingString:(NSString *)elementName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict;
- (NewsModel *)getNewsModel:(NSDictionary *)dictionary;

@end

//NS_ASSUME_NONNULL_END
