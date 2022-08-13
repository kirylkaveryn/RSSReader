//
//  XMLParserMock.h
//  RSSReaderTests
//
//  Created by Kirill on 10.04.22.
//

#import <Foundation/Foundation.h>
#import "NewsModel.h"
#import "ParserProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMLParserMock: NSObject <ParserProtocol>

@property (nonatomic, nullable, copy) NSArray<NewsModel*>* fakeModels;
@property (nonatomic, nullable, retain) NSError* fakeError;

@end

NS_ASSUME_NONNULL_END
