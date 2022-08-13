//
//  RSSDetailsViewModelProtocol.h
//  RSSReader
//
//  Created by Kirill on 22.04.22.
//

#import <Foundation/Foundation.h>
#import "NewsModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RSSDetailsViewModelProtocol <NSObject>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSDate *date;

- (instancetype)initWithNewsModel:(NewsModel *)newsModel;
- (instancetype)initWithTitle:(NSString *)title link:(NSString *)link summary:(NSString *)summary date:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
