//
//  CandidateListViewController.h
//  Intelect_v1
//
//  Created by Recommenu on 2/18/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CandidateListViewController : UITableViewController
@property (nonatomic, strong) NSArray *carModels;
@property (nonatomic, weak) NSString *electionId;

@property (nonatomic, strong) NSMutableArray *electionOfficeArr;
@property (nonatomic, strong) NSMutableArray *electionPartyArr;
@property (nonatomic, strong) NSMutableArray *ballotNamesArr;
@property (nonatomic, strong) NSMutableArray *candidateIdArr;
@end
