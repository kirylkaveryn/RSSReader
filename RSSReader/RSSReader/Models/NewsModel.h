//
//  NewsModel.h
//  RSSReader
//
//  Created by Kirill on 28.01.22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSDate *date;

- (instancetype)initWithTitle:(NSString *)title link:(NSString *)link summary:(NSString *)summary date:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
