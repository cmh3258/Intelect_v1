//
//  PageContentViewController.m
//  Intelect
//
//  Created by Recommenu on 4/5/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import "PageContentViewController.h"
#import "MyManager.h"
#import "RssFeedTableViewController.h"

@interface PageContentViewController ()
{
    BOOL lastPage;
}

@end

@implementation PageContentViewController
@synthesize titleText = _titleText;
@synthesize buttonC, buttonD, buttonA, buttonB;


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
    
    //[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:(136/256.0) green:(136/256.0) blue:(46/256.0) alpha:(1.0)]];
    //[UINavigationBar appearance] setTitleTextAttributes:<#(NSDictionary *)#>
    
    self.titleLabel.font = [UIFont fontWithName:@"PTSans-Bold" size:16];
    self.titleLabel.text = self.titleText;
    self.titleLabel.numberOfLines = 3;
    //NSLog(@"this is it: %@", [self.testing objectAtIndex:3]);
    
    [self initializeButtonColor:buttonA];
    [self initializeButtonColor:buttonB];
    [self initializeButtonColor:buttonC];
    [self initializeButtonColor:buttonD];
    
    if(_pageIndex == 11)
        lastPage = TRUE;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonOne:(id)sender {
    UIButton *button = (UIButton *)sender;
    [button setBackgroundColor:[UIColor redColor]];
    
    MyManager *sharedManager = [MyManager sharedManager];
    NSMutableArray *the = sharedManager.theArray;
    [the replaceObjectAtIndex:_pageIndex withObject:@"ONE"];
    
    NSInteger count = 0;
    for (NSString *tes in the){
        NSLog(@"array print(the) %i (%i): %@", count, _pageIndex, tes);
        count += 1;
    }
}

- (IBAction)buttonTwo:(id)sender {
    MyManager *sharedManager = [MyManager sharedManager];
    NSMutableArray *the = sharedManager.theArray;
    [the replaceObjectAtIndex:_pageIndex withObject:@"TWO"];
    
    NSInteger count = 0;
    for (NSString *tes in the){
        NSLog(@"array print(the) %i (%i): %@", count, _pageIndex, tes);
        count += 1;
    }
}

-(void)initializeButtonColor:(UIButton *)button{
    [[button layer] setBorderWidth:2.0f];
    [[button titleLabel] setFont:[UIFont fontWithName:@"PTSans-Regular" size:16]];
    [[button layer] setBorderColor:[UIColor colorWithRed:(0/255.0) green:(204/255.0) blue:(102/255.0) alpha:1].CGColor];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 10; // this value vary as per your desire
    button.clipsToBounds = YES;
}

-(void)setButtonColor:sender{
    UIButton *button = (UIButton *)sender;
    [[button layer] setBackgroundColor:[UIColor colorWithRed:(0/255.0) green:(204/255.0) blue:(102/255.0) alpha:1].CGColor];
    //[button setBackgroundColor:[UIColor colorWithRed:(0/255.0) green:(204/255.0) blue:(102/255.0) alpha:1].CGColor];
    //[button setBackgroundColor: [UIColor clearColor]];
    
    if(lastPage)
    {
        NSLog(@"should be last page.");
        [self checkDone];
    }
}

- (NSString *) getParty
{
    MyManager *sharedManager = [MyManager sharedManager];
    NSMutableArray *the = sharedManager.theArray;
    NSString *yoParty = sharedManager.yourParty;
    
    NSInteger totalCount = 0;
    for (NSNumber *b in the)
    {
        NSInteger myInteger = [b integerValue];
        totalCount += myInteger;
    }
    
    if (totalCount<=-20) {
        yoParty = @"Very Liberal Democrat";
        sharedManager.yourParty = @"Very Liberal Democrat";
    }
    else if (totalCount<=-12) {
        yoParty = @"Liberal Democrat";
        sharedManager.yourParty = @"Liberal Democrat";
    }
    else if (totalCount<=-2) {
        yoParty = @"Moderate Democrat";
        sharedManager.yourParty = @"Moderate Democrat";
    }
    else if (totalCount<2) {
        yoParty = @"Independent";
        sharedManager.yourParty = @"Independent";
    }
    else if (totalCount<12) {
        yoParty = @"Moderate Republican";
        sharedManager.yourParty = @"Moderate Republican";
    }
    else if (totalCount<20) {
        yoParty = @"Conservative Republican";
        sharedManager.yourParty = @"Conservative Republican";
    }
    else {
        yoParty = @"Very Conservative Republican";
        sharedManager.yourParty = @"Very Conservative Republican";
    }
    
    NSLog(@"set the userdefaults(pagecontroller)");
    [[NSUserDefaults standardUserDefaults] setObject:sharedManager.yourParty forKey:@"yourParty"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasDoneQuiz"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    return yoParty;
}

- (void)checkDone
{
    NSLog(@"@]]--checkDone");
    
    MyManager *sharedManager = [MyManager sharedManager];
    NSMutableArray *the = sharedManager.theArray;
    
    //NSString *answer = nil;
    //NSUInteger index = [namesArray indexOfObject:[NSNumber numberWithInt:0]];
    
    /*
     *  Looking to see if user answered every question
     */
    NSInteger zeroCount = 0;
    for (NSNumber *b in the)
    {
        NSLog(@"checking for 0's: %@", b);
        if([b  isEqual: @"0"])
        {
            NSLog(@"this is a 0");
            zeroCount+=1;
        }
    }
    
    /*
     *Person completely the Quiz
     */
    if(zeroCount <= 1)
    {
        //call algorithm
        NSString *yoParty = [self getParty];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congradulations!" message:yoParty delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert addButtonWithTitle:@"Yes"];
        [alert show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You missed one." message:@"Do you really want to reset this game?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert addButtonWithTitle:@"Yes"];
        [alert show];
    }
}

/*
 *  Responding to the alertview
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"the is the alertView");
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Yes"])
    {
        NSLog(@"Button 1 was selected.");
        UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"rssFeed"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if([title isEqualToString:@"Cancel"])
    {
        NSLog(@"Button 2 was selected.");
    }
}

- (IBAction)actionA:(id)sender {
    [self setButtonColor:(id)sender];
    
    MyManager *sharedManager = [MyManager sharedManager];
    NSMutableArray *the = sharedManager.theArray;
    [the replaceObjectAtIndex:_pageIndex withObject:[NSNumber numberWithInt:2]];
    
    NSInteger count = 0;
    for (NSString *tes in the){
        NSLog(@"array print(the) %i (%i): %@", count, _pageIndex, tes);
        count += 1;
    }
    
    [buttonB setBackgroundColor:[UIColor clearColor]];
    [buttonC setBackgroundColor:[UIColor clearColor]];
    [buttonD setBackgroundColor:[UIColor clearColor]];
    
}
- (IBAction)actionB:(id)sender {
    [self setButtonColor:(id)sender];
    
    MyManager *sharedManager = [MyManager sharedManager];
    NSMutableArray *the = sharedManager.theArray;
    [the replaceObjectAtIndex:_pageIndex withObject:[NSNumber numberWithInt:1]];
    
    NSInteger count = 0;
    for (NSString *tes in the){
        NSLog(@"array print(the) %i (%i): %@", count, _pageIndex, tes);
        count += 1;
    }
    
    [buttonA setBackgroundColor:[UIColor clearColor]];
    [buttonC setBackgroundColor:[UIColor clearColor]];
    [buttonD setBackgroundColor:[UIColor clearColor]];
}
- (IBAction)actionC:(id)sender {
   [self setButtonColor:(id)sender];
    
    MyManager *sharedManager = [MyManager sharedManager];
    NSMutableArray *the = sharedManager.theArray;
    [the replaceObjectAtIndex:_pageIndex withObject:[NSNumber numberWithInt:-1]];
    
    NSInteger count = 0;
    for (NSString *tes in the){
        NSLog(@"array print(the) %i (%i): %@", count, _pageIndex, tes);
        count += 1;
    }
    
    [buttonB setBackgroundColor:[UIColor clearColor]];
    [buttonA setBackgroundColor:[UIColor clearColor]];
    [buttonD setBackgroundColor:[UIColor clearColor]];
}
- (IBAction)actionD:(id)sender {
    [self setButtonColor:(id)sender];
    
    MyManager *sharedManager = [MyManager sharedManager];
    NSMutableArray *the = sharedManager.theArray;
    [the replaceObjectAtIndex:_pageIndex withObject:[NSNumber numberWithInt:-2]];
    
    NSInteger count = 0;
    for (NSString *tes in the){
        NSLog(@"array print(the) %i (%i): %@", count, _pageIndex, tes);
        count += 1;
    }
    
    [buttonB setBackgroundColor:[UIColor clearColor]];
    [buttonC setBackgroundColor:[UIColor clearColor]];
    [buttonA setBackgroundColor:[UIColor clearColor]];
    
}

@end
