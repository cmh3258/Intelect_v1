//
//  ViewController.m
//  iphone-quiz-app
//
//  Created by Navin Ratnayake on 3/19/14.
//  Copyright (c) 2014 Navin Ratnayake. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    //NSInteger localcount;
}


@end

@implementation ViewController

@synthesize Question, party, ab, bb, cb, db;

NSInteger questNumber;
NSInteger choices[12];

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    NSLog(@"QuestNumber: %li",(long)questNumber);
    
    [[ab layer] setBorderWidth:4.0f];
    [[ab layer] setBorderColor:[UIColor colorWithRed:(232/255.0) green:(124/255.0) blue:(0/255.0) alpha:1].CGColor];
    [[bb layer] setBorderWidth:4.0f];
    [[bb layer] setBorderColor:[UIColor colorWithRed:(232/255.0) green:(124/255.0) blue:(0/255.0) alpha:1].CGColor];
    [[cb layer] setBorderWidth:4.0f];
    [[cb layer] setBorderColor:[UIColor colorWithRed:(232/255.0) green:(124/255.0) blue:(0/255.0) alpha:1].CGColor];
    [[db layer] setBorderWidth:4.0f];
    [[db layer] setBorderColor:[UIColor colorWithRed:(232/255.0) green:(124/255.0) blue:(0/255.0) alpha:1].CGColor];

    
    if (choices[questNumber]!=0) {
        if (choices[questNumber]==-2) {
            ab.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(136/255.0) blue:(0/255.0) alpha:1];
        }
        else if (choices[questNumber]==-1) {
            bb.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(136/255.0) blue:(0/255.0) alpha:1];
        }
        else if (choices[questNumber]==1) {
            cb.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(136/255.0) blue:(0/255.0) alpha:1];
        }
        else {
            db.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(136/255.0) blue:(0/255.0) alpha:1];
        }
    }
    
	// Do any additional setup after loading the view, typically from a nib.
    //answers = [[NSMutableArray alloc] init];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)a:(id)sender {
    choices[questNumber] = -2;
    ab.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(136/255.0) blue:(0/255.0) alpha:1];
    bb.backgroundColor = [UIColor clearColor];
    cb.backgroundColor = [UIColor clearColor];
    db.backgroundColor = [UIColor clearColor];
}

- (IBAction)b:(id)sender {
    choices[questNumber] = -1;
    bb.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(136/255.0) blue:(0/255.0) alpha:1];
    ab.backgroundColor = [UIColor clearColor];
    cb.backgroundColor = [UIColor clearColor];
    db.backgroundColor = [UIColor clearColor];
}

- (IBAction)c:(id)sender {
    choices[questNumber] = 1;
    cb.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(136/255.0) blue:(0/255.0) alpha:1];
    bb.backgroundColor = [UIColor clearColor];
    ab.backgroundColor = [UIColor clearColor];
    db.backgroundColor = [UIColor clearColor];
}

- (IBAction)d:(id)sender {
    choices[questNumber] = 2;
    db.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(136/255.0) blue:(0/255.0) alpha:1];
    bb.backgroundColor = [UIColor clearColor];
    cb.backgroundColor = [UIColor clearColor];
    ab.backgroundColor = [UIColor clearColor];
}

- (IBAction)next:(id)sender {
    questNumber++;
}

- (IBAction)reveal:(id)sender {
    NSInteger count = 0;
    for (int i=0; i<12; i++) {
        count += choices[i];
    }
    if (count<=-20) {
        party.text = @"Very Liberal Democrat";
    }
    else if (count<=-12) {
        party.text = @"Liberal Democrat";
    }
    else if (count<=-2) {
        party.text = @"Moderate Democrat";
    }
    else if (count<2) {
        party.text = @"Independent";
    }
    else if (count<12) {
        party.text = @"Moderate Republican";
    }
    else if (count<20) {
        party.text = @"Conservative Republican";
    }
    else {
        party.text = @"Very Conservative Democrat";
    }
}

- (IBAction)back:(id)sender {
    questNumber--;
    NSLog(@"BACK clicked");
}

@end
