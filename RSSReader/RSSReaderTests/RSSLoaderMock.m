//
//  RSSLoaderMock.m
//  RSSReaderTests
//
//  Created by Kirill on 11.04.22.
//

#import "RSSLoaderMock.h"
#import "RSSError.h"

@implementation RSSLoaderMock

- (instancetype)initWithFakeData:(NSData*)fakeData {
    self = [super init];
    if (self) {
        _fakeData = [fakeData copy];
    };
    return self;
}

- (NSData *)getDataWithURL:(NSURL *)url error:(NSError **)error {
    *error = self.fakeError;
    return self.fakeData;
}

- (void)dealloc {
    [_fakeData release];
    _fakeData = nil;
    [super dealloc];
}

@end
