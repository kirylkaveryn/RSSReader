//
//  XMLParserMock.m
//  RSSReaderTests
//
//  Created by Kirill on 10.04.22.
//

#import "XMLParserMock.h"

@implementation XMLParserMock

- (void)parseModels:(NSData *)data completion:(void (^)(NSArray<NewsModel *>*, NSError *))completion {
    completion(self.fakeModels, self.fakeError);
}

@end
