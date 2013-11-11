//
//  BBUNikePlusActivity.h
//  NikeKit Example
//
//  Created by Boris Bügling on 10.11.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    BBUNikePlusAllDay = 1,
    BBUNikePlusRun,
    BBUNikePlusActivityTypeUnknown = INT_MAX,
} BBUNikePlusActivityType;

typedef enum {
    BBUNikePlusDeviceTypeFuelBand = 1,
    BBUNikePlusDeviceTypeiPhone,
    BBUNikePlusDeviceTypeiPod,
    BBUNikePlusDeviceTypeUnknown = INT_MAX,
} BBUNikePlusDeviceType;

typedef enum {
    BBUNikePlusStatusComplete = 1,
    BBUNikePlusStatusInProgress,
    BBUNikePlusStatusUnknown = INT_MAX,
} BBUNikePlusStatus;

@interface BBUNikePlusActivity : NSObject

@property NSString* activityId;
@property NSUInteger calories;
@property NSUInteger fuel;
@property CGFloat distance;
@property NSUInteger steps;
@property NSTimeInterval duration;
@property BBUNikePlusActivityType activityType;
@property NSDate* startTime;
@property NSTimeZone* activityTimeZone;
@property BBUNikePlusStatus status;
@property BBUNikePlusDeviceType deviceType;
@property NSArray* tags;

/* TODO: streams */

+(instancetype)activityFromJSON:(NSDictionary*)JSONDictionary;

@end
