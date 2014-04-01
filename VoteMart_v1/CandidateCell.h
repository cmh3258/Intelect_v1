//
//  CandidateCell.h
//  VoteSmart_v2.2
//
//  Created by Recommenu on 2/18/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CandidateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ballotName;
@property (weak, nonatomic) IBOutlet UILabel *partyName;
@property (weak, nonatomic) IBOutlet UILabel *positionName;


@end
