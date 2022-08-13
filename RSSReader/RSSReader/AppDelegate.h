//
//  AppDelegate.h
//  RSSReader
//
//  Created by Kirill on 27.01.22.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "NewsFeedViewController.h"
#import "NetworkingService.h"
#import "XMLParser.h"
#import "RSSBaseRouter.h"
#import "RSSLoader.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic, strong) UIWindow *window;

- (void)saveContext;


@end

