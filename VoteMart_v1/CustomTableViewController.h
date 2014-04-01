//
//  CustomTableViewController.h
//  VoteSmart_v2.2
//
//  Created by Recommenu on 2/18/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewController : UITableViewController
@property (nonatomic, strong) NSArray *carModels;
@property (nonatomic, strong) NSMutableArray *electionIdArray;
@property (nonatomic, strong) NSMutableArray *electionNameArray;
@property (weak, nonatomic) IBOutlet UISearchBar *searchElection;
@property (strong, nonatomic) IBOutlet UITableView *searchResultsTable;

@end
