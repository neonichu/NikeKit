//
//  BBUTableViewController.m
//  NikeKit Example
//
//  Created by Boris Bügling on 10.11.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import "BBUTableViewController.h"

@implementation BBUTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0);
        
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
    }
    return self;
}

- (void)registerClass:(Class)classObject forCellReuseIdentifier:(NSString *)identifier {
    [self.tableView registerClass:classObject forCellReuseIdentifier:identifier];
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
        
        self.tableView.dataSource = dataSource;
        [self.tableView reloadData];
    }
}

#pragma mark - UITableView delegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectionHandler) {
        self.selectionHandler(indexPath);
    }
}

@end
