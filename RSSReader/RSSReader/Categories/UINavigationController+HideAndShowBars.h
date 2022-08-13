//
//  UINavigationController+HideAndShowBars.h
//  RSSReader
//
//  Created by Kirill on 22.04.22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (HideAndShowBars)

- (void)setToolbarAndNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
