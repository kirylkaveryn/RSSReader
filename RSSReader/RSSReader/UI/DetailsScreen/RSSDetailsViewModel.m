//
//  RSSDetailsViewModel.m
//  RSSReader
//
//  Created by Kirill on 22.04.22.
//

#import "RSSDetailsViewModel.h"

@implementation RSSDetailsViewModel

@synthesize title =_title;
@synthesize link = _link;
@synthesize summary = _summary;
@synthesize date = _date;

- (instancetype)initWithNewsModel:(NewsModel *)newsModel {
    self = [super init];
    if (self) {
        [newsModel retain];
        _title = [newsModel.title copy];
        _link = [newsModel.link copy];
        _summary = [newsModel.summary copy];
        _date = [newsModel.date copy];
        [newsModel release];
    };
    return self;
}

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
