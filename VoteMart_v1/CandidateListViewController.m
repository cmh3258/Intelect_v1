//
//  CandidateListViewController.m
//  Intelect_v1
//
//  Created by Recommenu on 2/18/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import "CandidateListViewController.h"
#import "CandidateCell.h"
#import "AFNetworking.h"
#import "CandidateViewController.h"
#import "MyManager.h"

@interface CandidateListViewController ()
{
    UIActivityIndicatorView *spinner;
}
@property(strong) NSDictionary *weather;
@property(strong) NSArray *sideBar;
@property(strong, nonatomic)NSMutableArray *alphabetArray;
@property(strong, nonatomic)NSMutableArray *finalCandId;
@property(strong, nonatomic)NSMutableArray *final2CandId;
@property(nonatomic)NSInteger rowCount;
@end

@implementation CandidateListViewController
@synthesize electionOfficeArr = _electionOfficeArr;
@synthesize electionPartyArr = _electionPartyArr;
@synthesize ballotNamesArr = _ballotNamesArr;
@synthesize candidateIdArr = _candidateIdArr;
@synthesize alphabetArray;
@synthesize finalCandId = _finalCandId;
@synthesize final2CandId = _final2CandId;
@synthesize rowCount;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        #define votesmartID @"de8821c861738c681c61ce0dea5891d3"
    }
    return self;
}

- (NSMutableArray *) electionPartyArr
{
    if (!_electionPartyArr) {
        _electionPartyArr = [NSMutableArray new];
    }
    return _electionPartyArr;
}

- (NSMutableArray *) final2CandId
{
    if (!_final2CandId) {
        _final2CandId = [NSMutableArray new];
    }
    return _final2CandId;
}

- (NSMutableArray *) finalCandId
{
    if (!_finalCandId) {
        _finalCandId = [NSMutableArray new];
    }
    return _finalCandId;
}

- (NSMutableArray *) electionOfficeArr
{
    if (!_electionOfficeArr) {
        _electionOfficeArr = [NSMutableArray new];
    }
    return _electionOfficeArr;
}

- (NSMutableArray *) ballotNamesArr
{
    if (!_ballotNamesArr) {
        _ballotNamesArr = [NSMutableArray new];
    }
    return _ballotNamesArr;
}

- (NSMutableArray *) candidateIdArr
{
    if (!_candidateIdArr) {
        _candidateIdArr = [NSMutableArray new];
    }
    return _candidateIdArr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    /*
     *  Get your political party
     */
    MyManager *sharedManager = [MyManager sharedManager];
    NSString *yourParty = sharedManager.yourPartySimple;
    yourParty = [[NSUserDefaults standardUserDefaults] stringForKey:@"yourPartySimple"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    spinner = [[UIActivityIndicatorView alloc]
               initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    
    _carModels = @[@"hat",
                   @"car",
                   @"Vbag",
                   @"shelby",
                   @"mother"];
    
    _sideBar = @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"];
    
    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.votesmart.org/Candidates.getByElection?o=JSON&key=%@&electionId=%@", votesmartID, self.electionId]];
    
    //   NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:baseURL];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
        self.weather = (NSDictionary *)responseObject;
        //NSLog(@"%@",self.weather);
        NSDictionary *dict = [self.weather objectForKey:@"candidateList"];
        NSArray *ar = [dict objectForKey:@"candidate"];
        
        //NSLog(@"newy: %@", ar);
        
        //NSDictionary *cc = [ar objectAtIndex:0];
        for (NSDictionary *x in ar){
            NSDictionary *cb = x;
            
            NSString *ballotName = [cb objectForKey:@"ballotName"];
            NSString *candidateId = [cb objectForKey:@"candidateId"];
            NSString *electionOffice = [cb objectForKey:@"electionOffice"];
            NSString *electionParties = [cb objectForKey:@"electionParties"];
            
            NSLog(@"Bout to match party: %@", yourParty);
            if([yourParty isEqualToString:electionParties])
            {
                NSLog(@"matched your party! %@", yourParty);
                [self.electionOfficeArr addObject:electionOffice];
                [self.electionPartyArr addObject:electionParties];
                [self.candidateIdArr addObject:candidateId];
                [self.ballotNamesArr addObject:ballotName];
            }
            else if([yourParty isEqualToString:@"Independent"])
            {
                NSLog(@"Will show all since you are: %@", yourParty);
                [self.electionOfficeArr addObject:electionOffice];
                [self.electionPartyArr addObject:electionParties];
                [self.candidateIdArr addObject:candidateId];
                [self.ballotNamesArr addObject:ballotName];
            }
            //[self.electionIdArray addObject:electionid];
            //[self.electionNameArray addObject:name];
            NSLog(@"Anser: %@ , %@, %@, %@", ballotName, candidateId, electionOffice, electionParties);
        }
        //[self createAlphabetArray];
        //NSLog(@"...Calling get arrayofIds");
        //self.finalCandId = [self getArrayOfIds];
        
        //self.title = @"JSON Retrieved";
        //NSLog(@"%i", self.electionIdArray.count);
        //NSLog(@"%i", self.electionNameArray.count);
        
        NSLog(@"finished");
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
/*
-(void)createAlphabetArray
{
    NSLog(@"alphabetArray created");

    alphabetArray = [[NSMutableArray alloc]initWithCapacity:0];
    for(int i =0; i<_ballotNamesArr.count; i++){
        NSString *testName = [_ballotNamesArr objectAtIndex:i];
        if(testName.length > 0){
            NSString *firstletter = [[_ballotNamesArr objectAtIndex:i]substringToIndex:1];
            if(![alphabetArray containsObject:firstletter])
                [alphabetArray addObject:firstletter];
        }
    }
    
    [alphabetArray sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSLog(@"finished creating");
}
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"candidateSeq"])
    {
        NSLog(@"...prepareForSeque");
        CandidateViewController *detailViewController =
        [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView
                                    indexPathForSelectedRow];
        
        detailViewController.candidateId = [_candidateIdArr objectAtIndex: myIndexPath.row];
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
    //return alphabetArray.count;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return _candidateIdArr.count;
    //return 5;
    
    /*
    NSMutableArray *rowArray = [[NSMutableArray alloc]initWithCapacity:0];
    rowArray = [self getArrayOfRowsForSection:section];
    return rowArray.count;
     */
    return _candidateIdArr.count;
}

/*
-(NSArray *)titleForRow:(NSIndexPath *)indexPath{
    NSLog(@"---Call for titleForRow");
    NSMutableArray *rowArray = [[NSMutableArray alloc]initWithCapacity:0];
    NSMutableArray *results = [[NSMutableArray alloc]initWithCapacity:0];
    rowArray = [self getArrayOfRowsForSection:indexPath.section];
    results=[rowArray objectAtIndex:indexPath.row];
    return results;
}

-(NSInteger *)getSection:(NSIndexPath *)indexPath{
    NSLog(@"---Call for getSection");
    NSMutableArray *rowArray = [[NSMutableArray alloc]initWithCapacity:0];
    //NSUInteger *results;
    rowArray = [self getArrayOfRowsForSection:indexPath.section];
    return rowArray.count;
}
 */
/*
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *title;
    for (int i = 0; i <alphabetArray.count; i++){
        if(section==i)
            title = [alphabetArray objectAtIndex:i];
    }
    return title;
}
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CandidateCellC";
    CandidateCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSLog(@"ballot name: %@, int: %li", [_ballotNamesArr objectAtIndex:indexPath.row],(long)indexPath.row);
    
    // Configure the cell...
    cell.ballotName.text = [_ballotNamesArr objectAtIndex:indexPath.row];
    cell.positionName.text = [_electionOfficeArr objectAtIndex:indexPath.row];
    cell.partyName.text = [_electionPartyArr objectAtIndex:indexPath.row];

    cell.ballotName.font = [UIFont fontWithName:@"PTSans-Bold" size:17];
    cell.positionName.font = [UIFont fontWithName:@"PTSans-Regular" size:14];
    cell.partyName.font = [UIFont fontWithName:@"PTSans-Regular" size:14];
    //cell.ballotName.numberOfLines = 2;
    
    return cell;
}
/*
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    //return [_electionNameArray valueForKey:@"headerTitle"];
    return alphabetArray;
}
 */

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //CandidateViewController *trailsController = [[CandidateViewController alloc]];
    //trailsController.candidateId = [self.finalCandId objectAtIndex:indexPath.row];
    //[[self navigationController] pushViewController:trailsController animated:YES];
    */
    /*
    NSLog(@"(didselectrow) : %ld", (long)indexPath.row);
    NSLog(@"(didselectsection) : %ld", (long)indexPath.section);
    */
    
    //how many rows for each section
    /*
    for(int i = 0; i <= indexPath.section; i++){
        NSLog(@"In section: %i", i);
        NSMutableArray *rowArray = [self getArrayOfRowsForSection:indexPath.section];
        self.rowCount += rowArray.count;
        NSLog(@"rowCount now: %i", self.rowCount);
    }
    self.rowCount += indexPath.row;
    */
    //i need to get the section #
/*
}
*/
/*
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    NSLog(@"i am here %@", title);
    //return [indices indexOfObject:title];
    NSInteger indexOfTheObject = [alphabetArray indexOfObject:title];
    NSLog(@"number index: %i", indexOfTheObject);
    
    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:0 inSection:indexOfTheObject];
    [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionTop animated:YES];

    return indexOfTheObject;
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
