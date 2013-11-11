//
//  BBUAppDelegate.m
//  NikeKit Example
//
//  Created by Boris Bügling on 09.11.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import <AFNetworkActivityLogger/AFNetworkActivityLogger.h>

#import "BBUAppDelegate.h"
#import "BBUArrayDataSource.h"
#import "BBUDynamicDataSource.h"
#import "BBUNikePlusActivity.h"
#import "BBUNikePlusSessionManager.h"
#import "BBUTableViewController.h"
#import "Credentials.h"

@interface BBUAppDelegate ()

@property BBUNikePlusSessionManager* manager;
@property BBUTableViewController* rootList;

@end

#pragma mark -

@implementation BBUAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[[AFNetworkActivityLogger sharedLogger] startLogging];
    
    self.rootList = [[BBUTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:self.rootList];
    [self.window makeKeyAndVisible];
    
    self.manager = [[BBUNikePlusSessionManager alloc] initWithAccessToken:NikePlusAccessToken];
    [self.manager activitiesWithCompletionHandler:^(NSArray* responseObject, NSError *error) {
        if (!responseObject) {
            //textView.text = error.localizedDescription;
            //textView.textColor = [UIColor redColor];
            return;
        }
        
        NSAssert([responseObject isKindOfClass:[NSArray class]], @"Result is not an array.");
        
        BBUArrayDataSource* arrayDataSource = [[BBUArrayDataSource alloc] initWithArray:responseObject];
        arrayDataSource.titleSelector = @selector(activityId);
        self.rootList.dataSource = arrayDataSource;
        self.rootList.title = NSLocalizedString(@"Activities", nil);
        
        __weak typeof(self) sself = self;
        self.rootList.selectionHandler = ^(NSIndexPath* indexPath) {
            BBUNikePlusActivity* activity = responseObject[indexPath.row];
            
            BBUTableViewController* activityDetails = [[BBUTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            activityDetails.dataSource = [[BBUDynamicDataSource alloc] initWithModelObject:activity];
            activityDetails.title = activity.activityId;
            
            [sself.rootList.navigationController pushViewController:activityDetails animated:YES];
        };
    }];
    
    return YES;
}

@end
