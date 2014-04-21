//
//  QuizViewController.m
//  Intelect
//
//  Created by Recommenu on 4/5/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import "QuizViewController.h"
#import "MyManager.h"
#import <Social/Social.h>

@interface QuizViewController ()
@property (strong, nonatomic)NSMutableArray *arr;
@end

@implementation QuizViewController

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
    //this only loads once
    [super viewDidLoad];
    
    //[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:(136/256.0) green:(6/256.0) blue:(6/256.0) alpha:(1.0)]];
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController.navigationBar setTranslucent:NO];
    self.title = @"Party Quiz";
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"appcoda-logo.png"]];
    
    self.view.backgroundColor = [UIColor colorWithRed:(160/255.0) green:(160/255.0) blue:(160/255.0) alpha:1];
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:nil];
    UIBarButtonItem *cameraItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:nil];
    cameraItem.action = @selector(testit);
    NSArray *actionButtonItems = @[shareItem, cameraItem];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    
    //check to see if you already did the quiz
    MyManager *sharedManager = [MyManager sharedManager];
    NSString *yoParty = sharedManager.yourParty;
    BOOL didAlready = [[NSUserDefaults standardUserDefaults] boolForKey:@"HasDoneQuiz"];
    NSLog(@"yourParty you filled out: %@ %d", yoParty, didAlready);
    
    if(didAlready)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Just to remind you, you are:" message:yoParty delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert addButtonWithTitle:@"Retake"];
        [alert addButtonWithTitle:@"Share"];
        [alert show];
    }
    
    // Create the data model
    _pageTitles = @[@"There need to be stricter laws and regulations to protect the environment.",
                    @"The government should help more needy people even if it means going deeper in debt.",
                    @"The growing number of newcomers from other countries threaten traditional American customs and values.",
                    @"I never doubt the existence of God.",
                    @"Business corporations make too much profit.",
                    @"Gays and lesbians should be allowed to marry legally.",
                    @"The government needs to do more to make health care affordable and accessible.",
                    @"One parent can bring up a child as well as two parents together.",
                    @"Government regulation of business usually does more harm than good.",
                    @"Abortion should be illegal in all or most cases.",
                    @"Labor unions are necessary to protect the working person.",
                    @"Poor people have become too dependent on government assistance programs."
                    ];
    
    _pageImages = @[@"page1.png", @"page2.png", @"page3.png", @"page4.png"];
    _arr = [[NSMutableArray alloc] init];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 10);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 *  Responding to the alertview
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"the is the alertView");
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Okay"])
    {
        NSLog(@"Button 1 was selected.");
        UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"electionView"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([title isEqualToString:@"Share"])
    {
        NSLog(@"Post to FB!");
        MyManager *sharedManager = [MyManager sharedManager];
        NSString *party = sharedManager.yourParty;
        NSString *message1 = [@"Hey! I just found out that I am a " stringByAppendingString:party];
        NSString *message2 = [message1 stringByAppendingString:@". Find out which political party you align with the most by downloading the intELECT app. It just might suprise you!"];
        //if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:message2];
        [self presentViewController:controller animated:YES completion:Nil];
        //}
        UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"electionView"];
        [self.navigationController pushViewController:vc animated:YES];

    }
    else if([title isEqualToString:@"Retake"])
    {
        NSLog(@"Button 2 was selected.");
        
    }
}

-(void)testit
{
    NSLog(@"testit");
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"rssFeed"];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
- (IBAction)startWalkere
{
    NSLog(@"back back back");
}

- (IBAction)startWalker:(id)sender
{
    NSLog(@"hello thesre");
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}
 */

#pragma mark - Page View Controller Data Source

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    NSLog(@"HI");
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSLog(@"...before controller");
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound))
    {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSLog(@"...after controller");
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    NSInteger test = ((PageContentViewController*) viewController).test;
    
    if(test>0)
        [self.arr addObject:@"play"];
    
    NSLog(@"afterView: %lu, %li", (unsigned long)index, (long)test);
    
    for (NSString *tes in self.arr)
    {
        NSLog(@"array main: %@", tes);
    }
    
    if (index == NSNotFound)
    {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count])
    {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    NSLog(@"count: %lu index: %lu", (unsigned long)[self.pageTitles count], (unsigned long)index);
    //NSInteger cou = [self.pageTitles count];
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    NSLog(@">>loaded page %lu", (unsigned long)index);
    
    //pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;

    return pageContentViewController;
}


/*
 *  displaying the page dots indicator
 */
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
