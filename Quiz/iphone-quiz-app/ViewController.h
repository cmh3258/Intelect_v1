//
//  ViewController.h
//  iphone-quiz-app
//
//  Created by Navin Ratnayake on 3/19/14.
//  Copyright (c) 2014 Navin Ratnayake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController
- (IBAction)a:(id)sender;
- (IBAction)b:(id)sender;
- (IBAction)c:(id)sender;
- (IBAction)d:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)reveal:(id)sender;
- (IBAction)back:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *Question;
@property (strong, nonatomic) IBOutlet UILabel *party;
@property (strong, nonatomic) IBOutlet UIButton *ab;
@property (strong, nonatomic) IBOutlet UIButton *bb;
@property (strong, nonatomic) IBOutlet UIButton *cb;
@property (strong, nonatomic) IBOutlet UIButton *db;


@end
