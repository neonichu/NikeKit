//
//  BBUNikePlusTag.h
//  NikeKit Example
//
//  Created by Boris Bügling on 11.11.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    BBUNikePlusTagTypeEmotion = 1,
    BBUNikePlusTagTypeLocation,
    BBUNikePlusTagTypeTerrain,
    BBUNikePlusTagTypeWeather,
    BBUNikePlusTagTypeUnknown = INT_MAX,
} BBUNikePlusTagType;

typedef enum {
    BBUNikePlusTagValueAmped = 1,
    BBUNikePlusTagValueOutdoors,
    BBUNikePlusTagValueUnknown = INT_MAX,
} BBUNikePlusTagValue;

@interface BBUNikePlusTag : NSObject

@property BBUNikePlusTagType type;
@property BBUNikePlusTagValue value;

+(instancetype)tagFromJSON:(NSDictionary*)JSONDictionary;

@end
