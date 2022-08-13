//
//  ActivityIndicatior.h
//  RSSReader
//
//  Created by Kirill on 9.02.22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActivityIndicatior : NSObject

- (instancetype)initWithView:(UIView *)view andStyle:(UIActivityIndicatorViewStyle)style;
- (void)start;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
