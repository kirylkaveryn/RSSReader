//
//  UINavigationController+HideAndShowBars.m
//  RSSReader
//
//  Created by Kirill on 22.04.22.
//

#import "UINavigationController+HideAndShowBars.h"

@implementation UINavigationController (HideAndShowBars)

- (void)setToolbarAndNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    [self setNavigationBarHidden:hidden animated:animated];
    [self setToolbarHidden:hidden animated:animated];
}

@end
