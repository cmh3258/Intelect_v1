//
//  QuizViewController.m
//  Intelect
//
//  Created by Recommenu on 4/5/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import "QuizViewController.h"
#import "MyManager.h"

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
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:(136/256.0) green:(6/256.0) blue:(6/256.0) alpha:(1.0)]];
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController.navigationBar setTranslucent:NO];
    self.title = @"Party Quiz";
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"appcoda-logo.png"]];
    
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:nil];
    UIBarButtonItem *cameraItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:nil];
    
    cameraItem.action = @selector(testit);
    
    NSArray *actionButtonItems = @[shareItem, cameraItem];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    
    //check to see if you already did the quiz
    MyManager *sharedManager = [MyManager sharedManager];
    NSString *yoParty = sharedManager.yourParty;
    BOOL didAlready = [[NSUserDefaults standardUserDefaults] boolForKey:@"HasDoneQuiz"];
    NSLog(@"yourParty you filled out: %@ %hhd", yoParty, didAlready);
    
    if(didAlready)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Just to remind you, you are:" message:yoParty delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert addButtonWithTitle:@"Retake"];
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
    
    /*
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(startWalkere)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Show View" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 340.0, 160.0, 40.0);
    [self.view addSubview:button];
    */
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
        UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"rssFeed"];
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

- (IBAction)startWalkere{
    NSLog(@"back back back");
}

- (IBAction)startWalker:(id)sender {
    
    NSLog(@"hello thesre");
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}


#pragma mark - Page View Controller Data Source

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    NSLog(@"HI");
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSLog(@"...before controller");
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
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
    
    NSLog(@"afterView: %i, %i", index, test);
    
    for (NSString *tes in self.arr){
        NSLog(@"array main: %@", tes);
    }
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    NSLog(@"count: %i index: %i", [self.pageTitles count], index);
    
    NSInteger cou = [self.pageTitles count];
    
    /*
    if (self.pageTitles[index] == self.pageTitles[cou-1]) {
        NSLog(@"here");
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self
                   action:@selector(aMethod:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"Show View" forState:UIControlStateNormal];
        button.frame = CGRectMake(80.0, 240.0, 160.0, 40.0);
        [self.view addSubview:button];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Really reset?" message:@"Do you really want to reset this game?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert addButtonWithTitle:@"Yes"];
        [alert show];
    }
     */
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    NSLog(@">>loaded page %i", index);
    
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
