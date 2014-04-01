//
//  CandidateViewController.h
//  VoteSmart_v2.2
//
//  Created by Recommenu on 2/19/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CandidateViewController : UIViewController
@property (weak, nonatomic) NSString *candidateId;
@property (weak, nonatomic) IBOutlet UILabel *candidateName;
@property (weak, nonatomic) IBOutlet UILabel *candidateBirthPlace;
@property (weak, nonatomic) IBOutlet UILabel *candidateGroups;
@property (weak, nonatomic) IBOutlet UIImageView *candidateImage;
@property (weak, nonatomic) IBOutlet UILabel *candidateF;
@end
