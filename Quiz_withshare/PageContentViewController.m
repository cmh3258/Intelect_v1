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
#import <Social/Social.h>

@interface PageContentViewController ()
{
    BOOL lastPage;
    BOOL flip;
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
    
    self.titleLabel.font = [UIFont fontWithName:@"PTSans-Bold" size:16];
    self.titleLabel.text = self.titleText;
    self.titleLabel.numberOfLines = 3;
    
    [self initializeButtonColor:buttonA];
    [self initializeButtonColor:buttonB];
    [self initializeButtonColor:buttonC];
    [self initializeButtonColor:buttonD];
    
    if(_pageIndex == 11)
        lastPage = TRUE;
    if ((_pageIndex == 2)||(_pageIndex == 3)||(_pageIndex == 8)||(_pageIndex == 9)||(_pageIndex == 11)) {
        flip = TRUE;
    }
    else{
        flip = FALSE;
    }
    MyManager *sharedManager = [MyManager sharedManager];
    NSMutableArray *the = sharedManager.theArray;
    NSNumber *t = the[_pageIndex];
    if(t.integerValue==2)
    {
        if (flip) {
            buttonA.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(204/255.0) blue:(102/255.0) alpha:1];
        }
        else{
            buttonD.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(204/255.0) blue:(102/255.0) alpha:1];
        }
    }
    if(t.integerValue==1)
    {
        if (flip) {
            buttonB.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(204/255.0) blue:(102/255.0) alpha:1];
        }
        else{
            buttonC.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(204/255.0) blue:(102/255.0) alpha:1];
        }
    }
    if(t.integerValue==-1)
    {
        if (flip) {
            buttonC.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(204/255.0) blue:(102/255.0) alpha:1];
        }
        else{
            buttonB.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(204/255.0) blue:(102/255.0) alpha:1];
        }
    }
    if(t.integerValue==-2)
    {
        if (flip) {
            buttonD.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(204/255.0) blue:(102/255.0) alpha:1];
        }
        else{
            buttonA.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(204/255.0) blue:(102/255.0) alpha:1];
        }
    }

    
    self.view.backgroundColor = [UIColor colorWithRed:(160/255.0) green:(160/255.0) blue:(160/255.0) alpha:1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initializeButtonColor:(UIButton *)button{
    [[button layer] setBorderWidth:2.0f];
    [[button titleLabel] setFont:[UIFont fontWithName:@"PTSans-Bold" size:16]];
    [[button layer] setBorderColor:[UIColor colorWithRed:(64/255.0) green:(64/255.0) blue:(64/255.0) alpha:1].CGColor];
    [[button layer] setBackgroundColor:[UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1].CGColor];
    [button setTitleColor:[UIColor colorWithRed:(50/255.0) green:(50/255.0) blue:(50/255.0) alpha:1] forState:UIControlStateNormal];
    button.layer.cornerRadius = 10;
    button.clipsToBounds = YES;
}

-(void)setButtonColor:sender{
    UIButton *button = (UIButton *)sender;
    [[button layer] setBackgroundColor:[UIColor colorWithRed:(0/255.0) green:(204/255.0) blue:(102/255.0) alpha:1].CGColor];
    //NSInteger *counter = [self getCount];
    /*
    if(lastPage)
    {
        NSLog(@"should be last page.");
        [self checkDone];
    }
     */
    [self checkDone];
}

-(NSInteger)getCount
{
    NSInteger num = 0;
    
    
    return num;
}

- (NSString *)getParty
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
    
    
    if (totalCount<=-20)
    {
        yoParty = @"Very Liberal Democrat";
        sharedManager.yourParty = @"Very Liberal Democrat";
        sharedManager.yourPartySimple = @"Democratic";
    }
    else if (totalCount<=-12)
    {
        yoParty = @"Liberal Democrat";
        sharedManager.yourParty = @"Liberal Democrat";
        sharedManager.yourPartySimple = @"Democratic";
    }
    else if (totalCount<=-2)
    {
        yoParty = @"Moderate Democrat";
        sharedManager.yourParty = @"Moderate Democrat";
        sharedManager.yourPartySimple = @"Democratic";
    }
    else if (totalCount<2)
    {
        yoParty = @"Independent";
        sharedManager.yourParty = @"Independent";
        sharedManager.yourPartySimple = @"Independent";
    }
    else if (totalCount<12)
    {
        yoParty = @"Moderate Republican";
        sharedManager.yourParty = @"Moderate Republican";
        sharedManager.yourPartySimple = @"Republican";
    }
    else if (totalCount<20)
    {
        yoParty = @"Conservative Republican";
        sharedManager.yourParty = @"Conservative Republican";
        sharedManager.yourPartySimple = @"Republican";
    }
    else
    {
        yoParty = @"Very Conservative Republican";
        sharedManager.yourParty = @"Very Conservative Republican";
        sharedManager.yourPartySimple = @"Republican";
    }
    
    NSLog(@"set the userdefaults(pagecontroller)");
    [[NSUserDefaults standardUserDefaults] setObject:sharedManager.yourParty forKey:@"yourParty"];
    [[NSUserDefaults standardUserDefaults] setObject:sharedManager.yourPartySimple forKey:@"yourPartySimple"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasDoneQuiz"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return yoParty;
}

- (void)checkDone
{
    MyManager *sharedManager = [MyManager sharedManager];
    NSMutableArray *the = sharedManager.theArray;
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
    if((zeroCount <= 1) && lastPage)
    {
        //call algorithm
        [self getParty];
        NSString *yoParty = [self getParty];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:yoParty delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:@"Share", nil];
        //optional - add more buttons:
        //[alert addButtonWithTitle:@"Yes"];
        [alert show];
        
    }
    else if (lastPage)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You missed one." message:@"Go back and Answer the question." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        //[alert addButtonWithTitle:@"Yes"];
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
    
    if([title isEqualToString:@"Continue"])
    {
        NSLog(@"Button 1 was selected.");
        UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"electionView"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([title isEqualToString:@"Share"])
    {
        NSLog(@"Post to FB!");
        NSString *party = [self getParty];
        NSString *message1 = [@"Hey! I just found out that I am a " stringByAppendingString:party];
        NSString *message2 = [message1 stringByAppendingString:@". Find out which political party you align with the most by downloading the intELECT app. It just might suprise you!"];
        //if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:message2];
        [self presentViewController:controller animated:YES completion:Nil];
        //}

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
    //[the replaceObjectAtIndex:_pageIndex withObject:[NSNumber numberWithInt:2]];
    if(flip)
    {
        [the replaceObjectAtIndex:_pageIndex withObject:[NSNumber numberWithInt:2]];
    }
    else{
        [the replaceObjectAtIndex:_pageIndex withObject:[NSNumber numberWithInt:-2]];
    }
    
    NSInteger count = 0;
    for (NSString *tes in the){
        NSLog(@"array print(the) %li (%lu): %@", (long)count, (unsigned long)_pageIndex, tes);
        count += 1;
    }

    [buttonB setBackgroundColor:[UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1]];
    [buttonC setBackgroundColor:[UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1]];
    [buttonD setBackgroundColor:[UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1]];
    
}
- (IBAction)actionB:(id)sender {
    [self setButtonColor:(id)sender];
    
    MyManager *sharedManager = [MyManager sharedManager];
    NSMutableArray *the = sharedManager.theArray;
    //[the replaceObjectAtIndex:_pageIndex withObject:[NSNumber numberWithInt:1]];
    if(flip)
    {
        [the replaceObjectAtIndex:_pageIndex withObject:[NSNumber numberWithInt:1]];
    }
    else{
        [the replaceObjectAtIndex:_pageIndex withObject:[NSNumber numberWithInt:-1]];
    }
    
    NSInteger count = 0;
    for (NSString *tes in the)
    {
        NSLog(@"array print(the) %li (%lu): %@", (long)count, (unsigned long)_pageIndex, tes);
        count += 1;
    }
    
    [buttonA setBackgroundColor:[UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1]];
    [buttonC setBackgroundColor:[UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1]];
    [buttonD setBackgroundColor:[UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1]];
}
- (IBAction)actionC:(id)sender {
   [self setButtonColor:(id)sender];
    
    MyManager *sharedManager = [MyManager sharedManager];
    NSMutableArray *the = sharedManager.theArray;
    //[the replaceObjectAtIndex:_pageIndex withObject:[NSNumber numberWithInt:-1]];
    if (flip) {
        [the replaceObjectAtIndex:_pageIndex withObject:[NSNumber numberWithInt:-1]];
    }
    else{
        [the replaceObjectAtIndex:_pageIndex withObject:[NSNumber numberWithInt:1]];
    }
    
    NSInteger count = 0;
    for (NSString *tes in the)
    {
        NSLog(@"array print(the) %li (%lu): %@", (long)count, (unsigned long)_pageIndex, tes);
        count += 1;
        
    }
    
    [buttonB setBackgroundColor:[UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1]];
    [buttonA setBackgroundColor:[UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1]];
    [buttonD setBackgroundColor:[UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1]];
}
- (IBAction)actionD:(id)sender {
    [self setButtonColor:(id)sender];
    
    MyManager *sharedManager = [MyManager sharedManager];
    NSMutableArray *the = sharedManager.theArray;
    //[the replaceObjectAtIndex:_pageIndex withObject:[NSNumber numberWithInt:-2]];
    if(flip)
    {
        [the replaceObjectAtIndex:_pageIndex withObject:[NSNumber numberWithInt:-2]];
    }
    else{
        [the replaceObjectAtIndex:_pageIndex withObject:[NSNumber numberWithInt:2]];
    }
    
    NSInteger count = 0;
    for (NSString *tes in the)
    {
        NSLog(@"array print(the) %li (%lu): %@", (long)count, (unsigned long)_pageIndex, tes);
        count += 1;
    }
    
    [buttonB setBackgroundColor:[UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1]];
    [buttonC setBackgroundColor:[UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1]];
    [buttonA setBackgroundColor:[UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1]];
    
}
@end
