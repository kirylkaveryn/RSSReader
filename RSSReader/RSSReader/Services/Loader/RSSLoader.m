//
//  RSSLoader.m
//  RSSReader
//
//  Created by Kirill on 11.04.22.
//

#import "RSSLoader.h"

@implementation RSSLoader

- (NSData *)getDataWithURL:(NSURL *)url error:(NSError **)error {
    NSURL *inputURL = [[url copy] autorelease];
    NSData *data;
    data = [NSData dataWithContentsOfURL:inputURL options:NSDataReadingMapped error:error];
    return data;
}


@end
