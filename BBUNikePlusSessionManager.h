//
//  BBUNikePlusSessionManager.h
//  NikeKit Example
//
//  Created by Boris Bügling on 09.11.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void(^BBUNikePlusResultBlock)(id responseObject, NSError* error);

@interface BBUNikePlusSessionManager : AFHTTPSessionManager

-(id)initWithAccessToken:(NSString*)accessToken;
-(void)activitiesFromDate:(NSDate*)fromDate toDate:(NSDate*)toDate completionHandler:(BBUNikePlusResultBlock)completionHandler;
-(void)activitiesWithCompletionHandler:(BBUNikePlusResultBlock)completionHandler;
-(void)summaryWithCompletionHandler:(BBUNikePlusResultBlock)completionHandler;

@end
