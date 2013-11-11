//
//  BBUDynamicDataSource.h
//  TableThisForNow
//
//  Created by Boris Bügling on 15.05.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBUDynamicDataSource : NSObject <UITableViewDataSource>

-(id)initWithModelObject:(NSObject*)modelObject;

@end
