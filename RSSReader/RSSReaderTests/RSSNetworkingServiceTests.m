//
//  RSSNetworkingServiceTests.m
//  RSSReaderTests
//
//  Created by Kirill on 10.04.22.
//

#import <XCTest/XCTest.h>

#import "NetworkingService.h"
#import "XMLParserMock.h"
#import "RSSLoaderMock.h"
#import "RSSError.h"

@interface RSSNetworkingServiceTests : XCTestCase

@property (nonatomic, strong) RSSLoaderMock* loader;
@property (nonatomic, strong) XMLParserMock* parser;
@property (nonatomic, strong) NetworkingService* sutNetworkingService;

@end

@implementation RSSNetworkingServiceTests

- (void)setUp {
    [super setUp];
    self.parser = [[[XMLParserMock alloc] init] autorelease];
    self.loader = [[[RSSLoaderMock alloc] initWithFakeData:nil] autorelease];
    self.sutNetworkingService = [[[NetworkingService alloc] initWithParser:self.parser andLoader:self.loader] autorelease];

    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    self.parser = nil;
    self.loader = nil;
    self.sutNetworkingService = nil;
    
    [super tearDown];
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testParserReturnNilData {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"expectation"];
 
    self.loader.fakeData = nil;
    self.loader.fakeError = [RSSError errorWithReason:NetworkingErrorNoInternetConnection];
    
    [self.sutNetworkingService loadFeedFromURL:@"lol" completion:^(NSArray<NewsModel *> *data, NSError *error) {
        XCTAssertNil(data);
        XCTAssertNotNil(error);
        [expectation fulfill];
    }];

    [self waitForExpectations:@[expectation] timeout:5];
}

- (void)testParserReturnData {

    XCTestExpectation *expectation = [self expectationWithDescription:@"expectation"];
 
    self.loader.fakeData = [NSData new];
    self.loader.fakeError = nil;
    
    self.parser.fakeError = nil;
    self.parser.fakeModels = [NSArray arrayWithObject:[NewsModel new]];
    
    [self.sutNetworkingService loadFeedFromURL:@"lol" completion:^(NSArray<NewsModel *> *data, NSError *error) {
        XCTAssertNotNil(data);
        XCTAssertNil(error);
        [expectation fulfill];
    }];

    [self waitForExpectations:@[expectation] timeout:5];

}

@end


