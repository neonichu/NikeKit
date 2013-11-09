//
//  BBUNikePlusSessionManager.m
//  NikeKit Example
//
//  Created by Boris Bügling on 09.11.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

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

#pragma mark -

-(void)activitiesWithCompletionHandler:(BBUNikePlusResultBlock)completionHandler {
    [self GET:@"me/sport/activities" additionalParameters:nil completionHandler:completionHandler];
}

-(void)summaryWithCompletionHandler:(BBUNikePlusResultBlock)completionHandler {
    [self GET:@"me/sport" additionalParameters:nil completionHandler:completionHandler];
}

@end
