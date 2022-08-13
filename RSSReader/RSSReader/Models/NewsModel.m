//
//  NewsModel.m
//  RSSReader
//
//  Created by Kirill on 28.01.22.
//

#import "NewsModel.h"

@interface NewsModel ()

@end

@implementation NewsModel

- (instancetype)initWithTitle:(NSString *)title link:(NSString *)link summary:(NSString *)summary date:(NSDate *)date {
    self = [super init];
    if (self) {
        _title = [title copy];
        _link = [link copy];
        _summary = [summary copy];
        _date = [date copy];
    };
    return self;
}

- (void)dealloc {
    [_link release];
    [_title release];
    [_summary release];
    [_date release];
    [super dealloc];
}

@end
