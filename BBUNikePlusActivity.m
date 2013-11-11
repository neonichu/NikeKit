//
//  BBUNikePlusActivity.m
//  NikeKit Example
//
//  Created by Boris Bügling on 10.11.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import <ISO8601DateFormatter/ISO8601DateFormatter.h>
#import <KZPropertyMapper/KZPropertyMapper.h>

#import "BBUNikePlusActivity.h"
#import "BBUNikePlusTag.h"

static NSDictionary *mapActivityType, *mapDeviceType, *mapStatus;

@implementation BBUNikePlusActivity

+(instancetype)activityFromJSON:(NSDictionary *)JSONDictionary {
    return [[[self class] alloc] initWithDictionary:JSONDictionary];
}

+(void)load {
    mapActivityType = @{ @(BBUNikePlusAllDay):  @"ALL_DAY",
                         @(BBUNikePlusRun):     @"RUN" };
    
    mapDeviceType = @{ @(BBUNikePlusDeviceTypeFuelBand):    @"FUELBAND",
                       @(BBUNikePlusDeviceTypeiPhone):      @"IPHONE",
                       @(BBUNikePlusDeviceTypeiPod):        @"IPOD" };
    
    mapStatus = @{ @(BBUNikePlusStatusComplete):    @"COMPLETE",
                   @(BBUNikePlusStatusInProgress):  @"IN_PROGRESS" };
}

#pragma mark -

-(id)activityTypeFromString:(NSString*)activityType {
    NSNumber* value = [[mapActivityType allKeysForObject:activityType] firstObject];
    return value.integerValue == 0 ? @(BBUNikePlusActivityTypeUnknown) : value;
}

-(id)deviceTypeFromString:(NSString*)deviceType {
    NSNumber* value = [[mapDeviceType allKeysForObject:deviceType] firstObject];
    return value.integerValue == 0 ? @(BBUNikePlusDeviceTypeUnknown) : value;
}

-(id)initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    if (self) {
        self.activityType = BBUNikePlusActivityTypeUnknown;
        self.deviceType = BBUNikePlusDeviceTypeUnknown;
        self.status = BBUNikePlusStatusUnknown;
        
        [KZPropertyMapper mapValuesFrom:dictionary
                             toInstance:self
                           usingMapping:@{ @"activityId": KZProperty(activityId),
                                           @"activityTimeZone": KZCall(timeZoneFromString:, activityTimeZone),
                                           @"activityType": KZCall(activityTypeFromString:, activityType),
                                           @"deviceType": KZCall(deviceTypeFromString:, deviceType),
                                           @"metricSummary": @{
                                                   @"calories": KZProperty(calories),
                                                   @"fuel": KZProperty(fuel),
                                                   @"distance": KZProperty(distance),
                                                   @"steps": KZProperty(steps)
                                           },
                                           @"metrics": @{},
                                           @"startTime": KZCall(startTimeFromString:, startTime),
                                           @"status": KZCall(statusFromString:, status),
                                           @"tags": KZCall(tagsFromArray:, tags),
                                        }];
    }
    return self;
}

-(id)startTimeFromString:(NSString*)startTime {
    return [[ISO8601DateFormatter new] dateFromString:startTime];
}

-(id)statusFromString:(NSString*)status {
    NSNumber* value = [[mapStatus allKeysForObject:status] firstObject];
    return value.integerValue == 0 ? @(BBUNikePlusStatusUnknown) : value;
}

-(id)tagsFromArray:(NSArray*)array {
    NSMutableArray* tags = [@[] mutableCopy];
    
    for (NSDictionary* tag in array) {
        [tags addObject:[BBUNikePlusTag tagFromJSON:tag]];
    }
    
    return [tags copy];
}

-(id)timeZoneFromString:(NSString*)timeZone {
    return [[NSTimeZone alloc] initWithName:timeZone];
}



/*
 "duration": "0:01:00.0000",
 "streams": []
 */

@end
