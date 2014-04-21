//
//  WebViewController.m
//  Intelect
//
//  Created by Recommenu on 4/15/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import "WebViewController.h"
#import "SWRevealViewController.h"

@interface WebViewController ()
{
    NSString *govURL;
    UIActivityIndicatorView *spinner;
}
@end

@implementation WebViewController
@synthesize registrationURL, regHasURL, govView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.hidesBackButton = NO;
    [self.navigationController.navigationBar setTranslucent:NO];
    self.title = @"Government 101";
    
    // the spinner
    NSLog(@"spinner should be going");
    spinner = [[UIActivityIndicatorView alloc]
               initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    /*
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:nil];
    UIBarButtonItem *cameraItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:nil];
    cameraItem.action = @selector(testit);
    NSArray *actionButtonItems = @[shareItem, cameraItem];
    self.navigationItem.leftBarButtonItem = cameraItem;
    */
    /*
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 60.0f, 30.0f)];
    UIImage *backImage = [[UIImage imageNamed:@"back_button_normal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12.0f, 0, 12.0f)];
    [backButton setBackgroundImage:backImage  forState:UIControlStateNormal];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    */
    self.navigationItem.hidesBackButton = NO;
    
    // Change button color
    self.sideBarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.8f];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.sideBarButton.title = @"Menu";
    
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavBar.png"]];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    [self.sideBarButton setTarget: self.revealViewController];
    [self.sideBarButton setAction: @selector( revealToggle: )];
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //if it is from registration page
    if(regHasURL){
        NSURL *myURL = [NSURL URLWithString: [registrationURL stringByAddingPercentEscapesUsingEncoding:
                                              NSUTF8StringEncoding]];
        NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
        [govView loadRequest:request];
        [spinner stopAnimating];
    }
    else{
        govURL = @"http://votesmart.org/education/government";
        NSURL *myURL = [NSURL URLWithString: [govURL stringByAddingPercentEscapesUsingEncoding:
                                              NSUTF8StringEncoding]];
        NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
        [govView loadRequest:request];
        [spinner stopAnimating];
    }
    
}

-(void) popBack {
    //[self.navigationController popViewControllerAnimated:YES];
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"rssFeed"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)testit
{
    NSLog(@"testit");
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"rssFeed"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
