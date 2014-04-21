//
//  CandidateViewController.m
//  Intelect_v1
//
//  Created by Recommenu on 2/19/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import "CandidateViewController.h"
#import "AFNetworking.h"

@interface CandidateViewController ()
{
    UIActivityIndicatorView *spinner;
}
@property(strong) NSDictionary *weather;

@end

@implementation CandidateViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        #define votesmartID @"de8821c861738c681c61ce0dea5891d3"
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    spinner = [[UIActivityIndicatorView alloc]
               initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.votesmart.org/CandidateBio.getBio?o=JSON&key=%@&candidateId=%@", votesmartID, self.candidateId]];
    
    //   NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:baseURL];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
        self.weather = (NSDictionary *)responseObject;
        NSLog(@"%@",self.weather);
        NSDictionary *dict = [self.weather objectForKey:@"bio"];
        //NSDictionary *candidateInfo = [dict objectForKey:@"candidate"];
        //NSDictionary *electionInfo = [dict objectForKey:@"election"];
        NSDictionary *generalInfo = [dict objectForKey:@"generalInfo"];
        
        //NSLog(@"newy: %@", candidateInfo);
        //NSLog(@"next newy: %@", [candidateInfo objectForKey:@"education"]);
        
        NSString *bioLink = [generalInfo objectForKey:@"linkBack"];
        /*
        NSString *fname = [candidateInfo objectForKey:@"firstName"];
        NSString *lname = [candidateInfo objectForKey:@"lastName"];
        NSString *photo = [candidateInfo objectForKey:@"photo"];
        NSString *education = [candidateInfo objectForKey:@"education"];
        NSString *family = [candidateInfo objectForKey:@"family"];
        NSString *orgMembership = [candidateInfo objectForKey:@"orgMembership"];
        NSString *profession = [candidateInfo objectForKey:@"profession"];
        NSString *religion = [candidateInfo objectForKey:@"religion"];
        NSString *office = [electionInfo objectForKey:@"office"];
        NSString *officeType = [electionInfo objectForKey:@"officeType"];
        NSString *parties = [electionInfo objectForKey:@"parties"];
        NSString *status = [electionInfo objectForKey:@"status"];
        
        NSLog(@"f: %@, l: %@", fname, lname);
        //NSLog(@"%@, %@, %@, %@, %@, %@, %@, %@",a,b,c,d,e,f,g,h);
        
        NSURL * imageURL = [NSURL URLWithString:photo];
        NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage * image = [UIImage imageWithData:imageData];
        NSString *fullname = [fname stringByAppendingString:@" "];
        fullname = [fullname stringByAppendingString:lname];
        
        NSMutableString *infoFull = [NSMutableString stringWithString:@" "];
        [infoFull appendString: family];
        [infoFull appendString: @" "];
        [infoFull appendString: education];
        
        //cell.summaryRSS.font = [UIFont fontWithName:@"PTSans-Regular" size:12];
        //cell.summaryRSS.numberOfLines = 2;
        
        NSLog(@"infofull: %@", infoFull);
        
        self.firstname.text = fname;
        self.lastname.text = lname;
        self.firstname.font = [UIFont fontWithName:@"PTSans-Bold" size:28];
        self.lastname.font = [UIFont fontWithName:@"PTSans-Bold" size:28];
        self.sublabel.text = parties;
        self.sublabel.font = [UIFont fontWithName:@"PTSans-Regular" size:14];
        
        self.profPic.image = image;
        */
        
        NSURL *myURL = [NSURL URLWithString: [bioLink stringByAddingPercentEscapesUsingEncoding:
                                              NSUTF8StringEncoding]];
        NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
        [self.bioView loadRequest:request];
        [spinner stopAnimating];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        NSLog(@"Error: %@", error);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Connecting To Internet"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }];
    
    
    
    // 5
    [operation start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
