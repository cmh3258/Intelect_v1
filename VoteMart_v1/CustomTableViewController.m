//
//  CustomTableViewController.m
//  Intelect_v1
//
//  Created by Recommenu on 2/18/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import "CustomTableViewController.h"
#import "CustonCell.h"
#import "AFNetworking.h"
#import "CandidateListViewController.h"
#import "SWRevealViewController.h"

static NSString * const BaseURLString = @"http://www.raywenderlich.com/demos/weather_sample/";

@interface CustomTableViewController ()
{
    UIActivityIndicatorView *spinner;
}

@property(strong) NSDictionary *weather;
@property(strong) NSArray *sideBar;
@property (nonatomic, strong) NSMutableArray *electionYear;

@end

@implementation CustomTableViewController
@synthesize electionNameArray = _electionNameArray;
@synthesize electionIdArray = _electionIdArray;
@synthesize electionYear = _electionYear;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        #define votesmartID @"de8821c861738c681c61ce0dea5891d3"
    }
    return self;
}
- (NSMutableArray *) electionNameArray
{
    if (!_electionNameArray) {
        _electionNameArray = [NSMutableArray new];
    }
    return _electionNameArray;
}
- (NSMutableArray *) electionIdArray
{
    if (!_electionIdArray) {
        _electionIdArray = [NSMutableArray new];
    }
    return _electionIdArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
     *  Need to check to see if they have done the quiz
     */
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasDoneQuiz"])
    {
        // This is the first launch ever
        NSLog(@"Hasnt done quiz");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh No!" message:@"You have not taken the quiz, press okay to continue" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        //[alert addButtonWithTitle:@"Yes"];
        [alert show];
        
    }
    else
    {
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
        
        self.SideBarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.8f];
        [self.navigationController.navigationBar setTranslucent:NO];
        self.SideBarButton.title=@"Menu";
        
        // Set the side bar button action. When it's tapped, it'll show up the sidebar.
        [self.SideBarButton setTarget: self.revealViewController];
        [self.SideBarButton setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        
        // Set the gesture
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
        spinner = [[UIActivityIndicatorView alloc]
                   initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.center = CGPointMake(160, 240);
        spinner.hidesWhenStopped = YES;
        [self.view addSubview:spinner];
        [spinner startAnimating];
        
    _electionYear = [[NSMutableArray alloc] init];
    
    /*
    _sideBar = @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"];
    */
        
    _carModels = @[@"Volt",
                   @"Mini",
                   @"Venza",
                   @"S60",
                   @"Fortwo"];
    
    //NSString *string = [NSString stringWithFormat:@"%@weather.php?format=json", BaseURLString];
    //NSString *string = [NSString stringWithFormat:@"http://api.votesmart.org/Election.getElectionByZip?key=%@&zip5=78705", votesmartID];//, self.enteredEmailAddress];
    
    NSString *zipCode = [[NSUserDefaults standardUserDefaults] stringForKey:@"zipCode"];
    
    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.votesmart.org/Election.getElectionByZip?o=JSON&key=%@&zip5=%@", votesmartID, zipCode]];

 //   NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:baseURL];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        // 3
        self.weather = (NSDictionary *)responseObject;
        NSLog(@"%@",self.weather);
        NSDictionary *dict = [self.weather objectForKey:@"elections"];
        NSArray *ar = [dict objectForKey:@"election"];
        
        NSLog(@"newy: %@", ar);
        //NSDictionary *cc = [ar objectAtIndex:0];
        for (NSDictionary *x in ar){
            NSDictionary *cb = x;
            
            NSString *electionid = [cb objectForKey:@"electionId"];
            NSString *name = [cb objectForKey:@"name"];
            NSString *year = [cb objectForKey:@"electionYear"];
        
            [self.electionIdArray addObject:electionid];
            [self.electionNameArray addObject:name];
            [self.electionYear addObject:year];
            NSLog(@"Anser: %@ , %@, %@", electionid, name, year);
        }
        /*
        //self.title = @"JSON Retrieved";
        NSLog(@"%i", self.electionIdArray.count);
        NSLog(@"%i", self.electionNameArray.count);
        NSLog(@"finished");
        */
        [self.tableView reloadData];
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
 
}

/*
 This is where the search bar functionality works.
 */

/*
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"sarch results: %@", searchBar.text);
}
*/

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
        UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"quizPage"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return _electionNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCellC";
    CustonCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    long row = [indexPath row];
    cell.carModel.numberOfLines = 0;
    cell.carModel.text = _electionNameArray[row];
    cell.carModel.font = [UIFont fontWithName:@"PTSans-Bold" size:16];
    cell.carModel.numberOfLines = 2;
    return cell;
}
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CandidateListViewController *candidatesControl = [[CandidateListViewController alloc] init];
    //candidatesControl.arrayOfCandidates_m = [NSMutableArray new];;
    //candidatesControl.arrayOfCandidates_m = self.arrayOfCandidates;
    //NSMutableArray *testingthe = getCandidates(self.arrayOfIds_m[row]);
    // Push View Controller onto Navigation Stack
    //NSLog(@"coount in tableveiw - %i", self.arrayOfCandidates.count);
    [self.navigationController pushViewController:candidatesControl animated:YES];
}
*/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"candSegue"])
    {
        NSLog(@"mathc seque");
        CandidateListViewController *detailViewController =
        [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView
                                    indexPathForSelectedRow];
        
        /*
        detailViewController.carModels = [[NSArray alloc]
                                               initWithObjects: [self.electionIdArray
                                                                 objectAtIndex:[myIndexPath row]],
                                               nil];
        */

        detailViewController.electionId = [self.electionIdArray objectAtIndex:[myIndexPath row]];
    }
}
/*
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    //return [_electionNameArray valueForKey:@"headerTitle"];
    return _sideBar;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    //return [indices indexOfObject:title];
    NSUInteger indexOfTheObject = [_electionNameArray indexOfObject:title];
    return 10;
}
 */
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"candSegue"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CandidateListViewController *destViewController = segue.destinationViewController;
        //destViewController.test2 = _test;//@"testing the string;barack";
        //destViewController.arrayOfData_m = _arrayOfData;
    }
}
*/
 
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
