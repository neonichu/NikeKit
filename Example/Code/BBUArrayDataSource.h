//
//  BBUArrayDataSource.h
//  NikeKit Example
//
//  Created by Boris Bügling on 10.11.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBUArrayDataSource : NSObject <UITableViewDataSource>

@property SEL titleSelector;

-(id)initWithArray:(NSArray*)array;

@end
