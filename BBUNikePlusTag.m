//
//  BBUNikePlusTag.m
//  NikeKit Example
//
//  Created by Boris Bügling on 11.11.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import <KZPropertyMapper/KZPropertyMapper.h>

#import "BBUNikePlusTag.h"

static NSDictionary *mapTagType, *mapTagValue;

@implementation BBUNikePlusTag

+(void)load {
    mapTagType = @{ @(BBUNikePlusTagTypeEmotion):   @"EMOTION",
                    @(BBUNikePlusTagTypeLocation):  @"LOCATION",
                    @(BBUNikePlusTagTypeTerrain):   @"TERRAIN",
                    @(BBUNikePlusTagTypeWeather):   @"WEATHER" };
    
    mapTagValue = @{ @(BBUNikePlusTagValueAmped):       @"AMPED",
                     @(BBUNikePlusTagValueOutdoors):    @"OUTDOORS" };
}

+(instancetype)tagFromJSON:(NSDictionary *)JSONDictionary {
    return [[[self class] alloc] initWithDictionary:JSONDictionary];
}

#pragma mark -

-(NSString *)description {
    return [NSString stringWithFormat:@"%@ -> %@", mapTagType[@(self.type)], mapTagValue[@(self.value)]];
}

-(id)initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    if (self) {
        [KZPropertyMapper mapValuesFrom:dictionary
                             toInstance:self
                           usingMapping:@{ @"tagType": KZCall(tagTypeFromString:, type),
                                           @"tagValue": KZCall(tagValueFromString:, value) }];
    }
    return self;
}

-(id)tagTypeFromString:(NSString*)tagType {
    NSNumber* value = [[mapTagType allKeysForObject:tagType] firstObject];
    return value.integerValue == 0 ? @(BBUNikePlusTagTypeUnknown) : value;
}

-(id)tagValueFromString:(NSString*)tagValue {
    NSNumber* value = [[mapTagValue allKeysForObject:tagValue] firstObject];
    return value.integerValue == 0 ? @(BBUNikePlusTagValueUnknown) : value;
}

@end
