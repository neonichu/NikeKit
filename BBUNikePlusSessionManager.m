//
//  BBUNikePlusSessionManager.m
//  NikeKit Example
//
//  Created by Boris Bügling on 09.11.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import <ISO8601DateFormatter/ISO8601DateFormatter.h>

#import "BBUNikePlusActivity.h"
#import "BBUNikePlusSessionManager.h"

@interface BBUNikePlusSessionManager ()

@property NSString* accessToken;

@end

#pragma mark -

@implementation BBUNikePlusSessionManager

-(id)initWithAccessToken:(NSString*)accessToken {
    NSURLSessionConfiguration* sessionConfiguraton = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguraton.HTTPAdditionalHeaders = @{ @"Accept": @"application/json", @"appid": @"NikeKit" };
    
    self = [super initWithBaseURL:[NSURL URLWithString:@"https://api.nike.com"] sessionConfiguration:sessionConfiguraton];
    if (self) {
        self.accessToken = accessToken;
    }
    return self;
}

-(NSURLSessionDataTask *)GET:(NSString *)URLString
        additionalParameters:(NSDictionary *)parameters
           completionHandler:(BBUNikePlusResultBlock)completionHandler {
    if (!parameters) {
        parameters = @{};
    }
    
    NSMutableDictionary* mutableParameters = [parameters mutableCopy];
    mutableParameters[@"access_token"] = self.accessToken;
    
    return [self GET:URLString parameters:mutableParameters
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 if (completionHandler) {
                     completionHandler(responseObject, nil);
                 }
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if (completionHandler) {
                     completionHandler(nil, error);
                 }
             }];
}

-(NSString*)stringFromDate:(NSDate*)date {
    ISO8601DateFormatter* formatter = [ISO8601DateFormatter new];
    formatter.format = ISO8601DateFormatCalendar;
    return [formatter stringFromDate:date];
}

#pragma mark -

-(void)activitiesFromDate:(NSDate*)fromDate
                   toDate:(NSDate*)toDate
        completionHandler:(BBUNikePlusResultBlock)completionHandler {
    [self activitiesFromDate:fromDate toDate:toDate paginationPage:0 numberOfRecords:0 completionHandler:completionHandler];
}

-(void)activitiesFromDate:(NSDate*)fromDate
                   toDate:(NSDate*)toDate
           paginationPage:(NSUInteger)page
          numberOfRecords:(NSUInteger)numberOfRecords
        completionHandler:(BBUNikePlusResultBlock)completionHandler {
    NSMutableDictionary* parameters = [@{} mutableCopy];
    
    if (fromDate) {
        parameters[@"startDate"] = [self stringFromDate:fromDate];
    }
    
    if (toDate) {
        parameters[@"endDate"] = [self stringFromDate:toDate];
    }
    
    if (numberOfRecords > 0) {
        parameters[@"count"] = [@(numberOfRecords) stringValue];
    }
    
    if (page > 0) {
        parameters[@"offset"] = [@(page) stringValue];
    }
    
    [self GET:@"me/sport/activities" additionalParameters:parameters completionHandler:^(id responseObject, NSError *error) {
        if (!responseObject) {
            completionHandler(nil, error);
            return;
        }
        
        NSMutableArray* activities = [@[] mutableCopy];
        
        for (NSDictionary* activityJSON in responseObject[@"data"]) {
            [activities addObject:[BBUNikePlusActivity activityFromJSON:activityJSON]];
        }
        
        completionHandler([activities copy], nil);
    }];
}

-(void)activitiesWithCompletionHandler:(BBUNikePlusResultBlock)completionHandler {
    [self activitiesFromDate:nil toDate:nil paginationPage:0 numberOfRecords:0 completionHandler:completionHandler];
}

-(void)summaryWithCompletionHandler:(BBUNikePlusResultBlock)completionHandler {
    [self GET:@"me/sport" additionalParameters:nil completionHandler:completionHandler];
}

@end
