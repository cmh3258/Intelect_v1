//
//  CustomTableViewController.h
//  Intelect_v1
//
//  Created by Recommenu on 2/18/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewController : UITableViewController<UIAlertViewDelegate>
@property (nonatomic, strong) NSArray *carModels;
@property (nonatomic, strong) NSMutableArray *electionIdArray;
@property (nonatomic, strong) NSMutableArray *electionNameArray;
@property (weak, nonatomic) IBOutlet UISearchBar *searchElection;
@property (strong, nonatomic) IBOutlet UITableView *searchResultsTable;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *SideBarButton;

@end
