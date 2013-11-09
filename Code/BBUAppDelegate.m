//
//  BBUAppDelegate.m
//  NikeKit Example
//
//  Created by Boris Bügling on 09.11.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import <AFNetworkActivityLogger/AFNetworkActivityLogger.h>

#import "BBUAppDelegate.h"
#import "BBUNikePlusSessionManager.h"
#import "Credentials.h"

@interface BBUAppDelegate ()

@property BBUNikePlusSessionManager* manager;

@end

#pragma mark -

@implementation BBUAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[[AFNetworkActivityLogger sharedLogger] startLogging];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [UIViewController new];
    [self.window makeKeyAndVisible];
    
    UITextView* textView = [[UITextView alloc] initWithFrame:self.window.rootViewController.view.bounds];
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    textView.textContainerInset = UIEdgeInsetsMake(30.0, 0.0, 0.0, 0.0);
    [self.window.rootViewController.view addSubview:textView];
    
    self.manager = [[BBUNikePlusSessionManager alloc] initWithAccessToken:NikePlusAccessToken];
    [self.manager activitiesWithCompletionHandler:^(id responseObject, NSError *error) {
        if (!responseObject) {
            textView.text = error.localizedDescription;
            textView.textColor = [UIColor redColor];
            return;
        }
        
        textView.text = [responseObject description];
    }];
    
    return YES;
}

@end
