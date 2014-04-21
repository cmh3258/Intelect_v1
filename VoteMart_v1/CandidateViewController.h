//
//  CandidateViewController.h
//  Intelect_v1
//
//  Created by Recommenu on 2/19/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CandidateViewController : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) NSString *candidateId;

@property (weak, nonatomic) IBOutlet UILabel *firstname;
@property (weak, nonatomic) IBOutlet UILabel *lastname;
@property (weak, nonatomic) IBOutlet UILabel *sublabel;
@property (weak, nonatomic) IBOutlet UIImageView *profPic;

@property (weak, nonatomic) IBOutlet UIWebView *bioView;
@end
