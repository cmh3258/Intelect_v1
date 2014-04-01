//
//  CandidateViewController.m
//  VoteSmart_v2.2
//
//  Created by Recommenu on 2/19/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import "CandidateViewController.h"
#import "AFNetworking.h"

@interface CandidateViewController ()
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
    
    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.votesmart.org/CandidateBio.getBio?o=JSON&key=%@&candidateId=%@", votesmartID, self.candidateId]];
    
    //   NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:baseURL];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
        self.weather = (NSDictionary *)responseObject;
        //NSLog(@"%@",self.weather);
        NSDictionary *dict = [self.weather objectForKey:@"bio"];
        NSDictionary *candidateInfo = [dict objectForKey:@"candidate"];
        NSDictionary *electionInfo = [dict objectForKey:@"election"];
        //NSLog(@"newy: %@", candidateInfo);
        
        //NSLog(@"next newy: %@", [candidateInfo objectForKey:@"education"]);
        NSString *a = [candidateInfo objectForKey:@"homeCity"];
        NSString *b = [candidateInfo objectForKey:@"orgMembership"];
        NSString *c = [candidateInfo objectForKey:@"photo"];
        NSString *d = [candidateInfo objectForKey:@"profession"];

        NSString *e = [electionInfo objectForKey:@"ballotName"];
        NSString *f = [electionInfo objectForKey:@"office"];
        NSString *g = [electionInfo objectForKey:@"parties"];
        NSString *h = [electionInfo objectForKey:@"status"];
        
        NSURL * imageURL = [NSURL URLWithString:c];
        NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage * image = [UIImage imageWithData:imageData];
        
        self.candidateName.text = e;
        self.candidateBirthPlace.text = d;
        self.candidateF.text = f;
        self.candidateGroups.text = c;
        self.candidateImage.image = image;
        
        //self.title = @"JSON Retrieved";
        //NSLog(@"%i", self.electionIdArray.count);
        //NSLog(@"%i", self.electionNameArray.count);
        NSLog(@"(CVC) ballotName: %@", e);
        //NSLog(@"finished %@, %@, %@, %@, %@, %@, %@, %@", a, b, c, d, e, f, g, h);
        //[self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
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
