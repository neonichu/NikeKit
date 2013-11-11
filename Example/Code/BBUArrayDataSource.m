//
//  BBUArrayDataSource.m
//  NikeKit Example
//
//  Created by Boris Bügling on 10.11.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import "BBUArrayDataSource.h"

@interface BBUArrayDataSource ()

@property NSArray* array;

@end

#pragma mark -

@implementation BBUArrayDataSource

-(id)initWithArray:(NSArray *)array {
    self = [super init];
    if (self) {
        self.array = array;
        self.titleSelector = @selector(title);
    }
    return self;
}

#pragma mark - UITableView data source methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"
                                                            forIndexPath:indexPath];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    cell.textLabel.text = [self.array[indexPath.row] performSelector:self.titleSelector];
#pragma clang diagnostic pop
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

@end
