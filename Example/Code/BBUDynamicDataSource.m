//
//  BBUDynamicDataSource.m
//  TableThisForNow
//
//  Created by Boris Bügling on 15.05.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import <objc/runtime.h>

#import "BBUDynamicDataSource.h"

@interface BBUDynamicDataSource () {
    unsigned int propertyCount;
    objc_property_t* properties;
}

@property (nonatomic, strong) NSObject* modelObject;

@end

#pragma mark -

@implementation BBUDynamicDataSource

-(id)initWithModelObject:(NSObject*)modelObject {
    self = [super init];
    if (self) {
        self.modelObject = modelObject;
        
        properties = class_copyPropertyList([self.modelObject class], &propertyCount);
    }
    return self;
}

-(void)dealloc {
    free(properties);
}

#pragma mark - UITableView data source methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"
                                                            forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithCString:property_getName(properties[indexPath.row])
                                             encoding:NSUTF8StringEncoding];
    
    UILabel* detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 160.0, 44.0)];
    detailLabel.text = [[self.modelObject valueForKey:cell.textLabel.text] description];
    cell.accessoryView = detailLabel;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return propertyCount;
}

@end
