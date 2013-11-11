//
//  BBUTableViewController.h
//  NikeKit Example
//
//  Created by Boris Bügling on 10.11.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BBUCellSelectionHandler)(NSIndexPath* indexPath);

@interface BBUTableViewController : UITableViewController

@property (nonatomic) id<UITableViewDataSource> dataSource;
@property (copy) BBUCellSelectionHandler selectionHandler;

-(void)registerClass:(Class)classObject forCellReuseIdentifier:(NSString *)identifier;

@end
