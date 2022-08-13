//
//  RSSLoaderMock.h
//  RSSReaderTests
//
//  Created by Kirill on 11.04.22.
//

#import <Foundation/Foundation.h>
#import "RSSLoader.h"

//NS_ASSUME_NONNULL_BEGIN

@interface RSSLoaderMock : NSObject <RSSLoaderProtocol>

@property (nonatomic, copy) NSData* fakeData;
@property (nonatomic, retain) NSError* fakeError;

- (instancetype)initWithFakeData:(NSData *)fakeData;

@end

//NS_ASSUME_NONNULL_END
