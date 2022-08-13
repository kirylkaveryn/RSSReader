//
//  XMLParser.m
//  RSSReader
//
//  Created by Kirill on 28.01.22.
//

#import "XMLParser.h"
#import "XMLParserHelper.h"
#import "RSSError.h"

static NSString *kXMLRSSTypeName = @"rss";
static NSString *kXMLAtomTypeName = @"feed";

@interface XMLParser () <NSXMLParserDelegate>

@property (nonatomic, copy) void (^completion)(NSArray<NewsModel *> *, NSError *);
@property (nonatomic, retain) NSMutableArray *newsModels;
@property (nonatomic, retain) NSMutableDictionary *newsDictionary;
@property (nonatomic, retain) NSMutableDictionary *channelDictionary;
@property (nonatomic, retain) NSMutableDictionary *parsingDictionary;
@property (nonatomic, retain) NSMutableString *parsingString;
@property (nonatomic, retain) NSXMLParser *parser;
@property (nonatomic, retain) XMLParserHelper *helper;

- (void)resetParserState;
- (void)setupParserHelper:(NSString *)elementName;

@end


@implementation XMLParser

- (void)parseModels:(NSData *)data completion:(void(^)(NSArray<NewsModel *> *, NSError *))completion {
    
    if (!data) {
        completion(nil, [RSSError errorWithReason:NetworkingErrorCorruptedData]);
        return;
    }
    [data retain];

    // initWithData only takes non-nil data
    self.parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
    self.completion = completion;
    self.parser.delegate = self;
    
    [self.parser parse];
    [data release];
}

// MARK: - Private methods

- (void)setupParserHelper:(NSString *)elementName {
    if ([elementName isEqualToString:kXMLAtomTypeName]) {
        self.helper = [XMLParserHelper helperWithXMLFormat:XMLAtom];
    } else if ([elementName isEqualToString:kXMLRSSTypeName]) {
        self.helper = [XMLParserHelper helperWithXMLFormat:XMLRSS];
    }
}

- (void)resetParserState {
    self.completion = nil;
    self.newsModels = nil;
    self.parsingDictionary = nil;
    self.parsingString = nil;
    self.helper = nil;
}

// MARK: - NSXMLParserDelegate
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (self.newsModels.count == 0 && parseError) {
        self.completion(self.newsModels, [RSSError errorWithReason:NetworkingErrorCorruptedData]);
    }
    if (self.newsModels.count > 0 && parseError) {
        self.completion(self.newsModels, [RSSError errorWithReason:NetworkingErrorUncompleteData]);
    }
    [self resetParserState];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.newsModels = [[NSMutableArray new] autorelease];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {

    // check format style only for 1st time
    if (!_helper) {
        [self setupParserHelper:elementName];
    }
    
    NSMutableDictionary *newDictionary = [self.helper getNewParsingDictionary:elementName];
    NSMutableString *newString = [self.helper getNewParsingString:elementName attributes:attributeDict];

    if (newDictionary) {
        self.newsDictionary = newDictionary;
    }
    if (newString) {
        self.parsingString = newString;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.parsingString appendString:string];
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    if (self.parsingString) {
        [self.newsDictionary setObject:self.parsingString forKey:elementName];
        self.parsingString = nil;
    };
    
    NewsModel *newsModel = [self.helper getNewsModel:self.newsDictionary];
    
    if (newsModel && [self.helper getNewParsingDictionary:elementName]) {
        [self.newsModels addObject:newsModel];
        self.newsDictionary = nil;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (self.completion) {
        self.completion(self.newsModels, nil);
    }
    [self resetParserState];
}

// MARK: - dealloc
- (void)dealloc {
    [_newsModels release];
    [_newsDictionary release];
    [_parsingDictionary release];
    [_parsingString release];
    [_parser release];
    [_helper release];
    [super dealloc];
}


@end
