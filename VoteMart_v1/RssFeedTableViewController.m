//
//  RssFeedTableViewController.m
//  VoteMart_v1
//
//  Created by Chris Hume on 3/19/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import "RssFeedTableViewController.h"
#import "RssCell.h"
#import "AFNetworking.h"
#import "NSDate+InternetDateTime.h"
#import "RssDetailViewController.h"

@interface RssFeedTableViewController ()
{
    NSArray *feeds;
    NSArray *listOfFeeds;
    
    NSXMLParser *parser;
    NSMutableArray *feeder;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *summary;
    NSMutableString *description;
    NSMutableString *content;
    NSMutableString *date;
    NSMutableString *pubDate;
    //NSMutableString *update;
    NSString *element;
    
    NSInteger feedCount;
}

@end

@implementation RssFeedTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    feedCount = 0;
    feeds = @[@"Volt",
                   @"Mini",
                   @"Venza",
                   @"S60",
                   @"Fortwo"];
    
    feeder = [[NSMutableArray alloc] init];
    listOfFeeds = [[NSArray alloc] init];
    
    listOfFeeds = @[
                    @"http://www.opensecrets.org/news/atom.xml",
                    
                    @"http://rss.cnn.com/rss/cnn_allpolitics.rss",
                    @"http://www.npr.org/rss/rss.php?id=1014",
                    @"http://rssfeeds.usatoday.com/TP-OnPolitics",
                    @"http://feeds.feedburner.com/projectvotesmart"
                    ];
    
    //feed://rss.cnn.com/rss/cnn_topstories.rss
    //feed://rss.cnn.com/rss/cnn_allpolitics.rss
    //feed://www.npr.org/rss/rss.php?id=1014
    //http://content.usatoday.com/marketing/rss/rsstrans.aspx?feedId=news25
    //feed://rssfeeds.usatoday.com/TP-OnPolitics
    
    //iffy rss feeds
    //http://votesmart.org/rss/key-votes
    //@"http://feeds.feedburner.com/SunlightFoundationReportingGroup",
    //@"http://rss.cnn.com/rss/cnn_topstories.rss", - not news
    
    /*
    NSURL *url = [NSURL URLWithString:@"http://www.opensecrets.org/news/atom.xml"];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    */
    
    /*
    NSString *feed = @"http://feeds.feedburner.com/RayWenderlich";
    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",feed]];
    NSURLRequest *request = [NSURLRequest requestWithURL:baseURL];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    // Make sure to set the responseSerializer correctly
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/atom+xml"];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/rss+xml", @"application/atom+xml",nil];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSXMLParser *XMLParser = (NSXMLParser *)responseObject;
        [XMLParser setShouldProcessNamespaces:YES];
        NSLog(@"%@", (NSXMLParser *)responseObject);
        // Leave these commented for now (you first need to add the delegate methods)
        
        XMLParser.delegate = self;
        [XMLParser parse];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        
    }];
    [operation start];
     
}
     */
    
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    NSInteger count = 0;
    for (NSString *feed in listOfFeeds) {
        NSLog(@"count: %i. Feed: %@", count, feed);
        NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",feed]];
        NSURLRequest *request = [NSURLRequest requestWithURL:baseURL];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        // Make sure to set the responseSerializer correctly
        operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
        operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/atom+xml"];
        operation.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/rss+xml", @"application/atom+xml",nil];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSXMLParser *XMLParser = (NSXMLParser *)responseObject;
            [XMLParser setShouldProcessNamespaces:YES];
            NSLog(@"%@", (NSXMLParser *)responseObject);
            
            // Leave these commented for now (you first need to add the delegate methods)
            XMLParser.delegate = self;
            [XMLParser parse];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error: %@", error);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
            
        }];
        count++;
    
        //[request setDelegate:self];
        
        [operationQueue addOperation:operation];
  
    }
    
    }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadTheTable
{
    [self.tableView reloadData];
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
    return feeder.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"rssCell";
    RssCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    //cell.titleRSS.text = [feeds objectAtIndex:indexPath.row];
   
    cell.titleRSS.text = [[feeder objectAtIndex:indexPath.row] objectForKey: @"title"];

    //cell.titleRSS.text = @"Test";
    //cell.titleRSS.numberOfLines = 2;
    
    //cell.titleRSS.numberOfLines = 2;
    //[cell.titleRSS sizeToFit];
    
    NSString *summy = [[feeder objectAtIndex:indexPath.row] objectForKey: @"summary"];
    NSString *dummy = [[feeder objectAtIndex:indexPath.row] objectForKey: @"description"];
    
    //NSLog(@"summary: %@, description: %@", summy, dummy);
    
    
    if([summy length]==0)
        cell.summaryRSS.text = dummy;
    else
        cell.summaryRSS.text = summy;
    
   // cell.summaryRSS.text = @"";

    NSDate *newDate = [[feeder objectAtIndex:indexPath.row] objectForKey: @"date"];
    NSLog(@"pub: %@.", newDate);
    
    //convert the date
    //NSDate *articleDate = [NSDate dateFromInternetDateTimeString:pubby formatHint:DateFormatHintRFC822];
   //NSDate *articleDate2 = [NSDate dateFromInternetDateTimeString:puddy formatHint:DateFormatHintRFC3339];
    
    /************/
    //NSString *dateString = @"Mon, 03 May 2010 18:54:26 +00:00";
    //NSString *dally = @"Fri, 14 Mar 2014 21:00:56 +0000";
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM.dd.yyyy"];
    NSString *dateStr1 = [dateFormat stringFromDate:newDate];
    //NSLog(@"(()()(>>>dateStr1 = %@", dateStr1);
    cell.dateRSS.text = dateStr1;
    
    
    //change the format displayed
    /*
    NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];
    [displayFormatter setLocale:locale];
    [displayFormatter setDateFormat:@"EEEE dd MMMM yyyy"];
    NSString *displayDate = [displayFormatter stringFromDate:formattedDate];
    NSLog(@"displayDate = %@", displayDate);
    */
     
    //[dateFormat setDateFormat:@"yyyyMMdd"];
    //NSDate *dater = [dateFormat dateFromString:pubby];
    //NSLog(@"dater: %@",dater);
    /**************
    
    NSDate *articleDate = [NSDate dateFromInternetDateTimeString:puddy formatHint:DateFormatHintRFC822];
    NSDate *articleDate2 = [NSDate dateFromInternetDateTimeString:puddy formatHint:DateFormatHintRFC3339];
    NSLog(@"----date: %@, %@", articleDate, articleDate2);
    
    articleDate = [NSDate dateFromInternetDateTimeString:pubby formatHint:DateFormatHintRFC822];
    articleDate2 = [NSDate dateFromInternetDateTimeString:pubby formatHint:DateFormatHintRFC3339];
    NSLog(@"----date2: %@, %@", articleDate, articleDate2);
    
     
    if([pubby length]==0){
        NSLog(@"in here with pubdate");
               cell.dateRSS.text = puddy;
        
    }
    else{
        //[dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
        //pubby = [dateFormat stringFromDate:date];
        
        NSLog(@"cell: %@", [[feeder objectAtIndex:indexPath.row] objectForKey: @"published"]);
        cell.dateRSS.text = pubby;
    }
     */
    return cell;
}

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

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    NSLog(@"element: %@",elementName);
    if ([element isEqualToString:@"entry"] || [element isEqualToString:@"item"]) {
        NSLog(@"--didstart");
        item    = [[NSMutableDictionary alloc] init];
        title   = [[NSMutableString alloc] init];
        link    = [[NSMutableString alloc] init];
        summary = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
        content = [[NSMutableString alloc] init];
        date = [[NSMutableString alloc] init];
        pubDate = [[NSMutableString alloc] init];
    }
    
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"entry"] || [elementName isEqualToString:@"item"]) {
        NSLog(@"--did end");
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [item setObject:summary forKey:@"summary"];
        [item setObject:description forKey:@"description"];
        [item setObject:content forKey:@"content"];
        
        //need to change the date to a NSDate
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        NSLocale *locale = [[NSLocale alloc]
                                initWithLocaleIdentifier:@"en_US"];
        [dateFormat setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss z"];
            
        NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
        [dateFormat2 setDateFormat:@"yyy-MM-dd'T'HH:mm:ssZ"];

        [dateFormat setLocale:locale];
        [dateFormat2 setLocale:locale];
        
        NSLog(@")))>> date in check: %@ %i", date, [date length]);
        if([date length]==0){
            NSLog(@"Has pubdate: %@", pubDate);
            NSString *linkTrim1 = [pubDate stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString *linkTrim2 = [pubDate stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            NSDate *formattedDate1 = [dateFormat dateFromString:linkTrim1];
            NSDate *formattedDate2 = [dateFormat dateFromString:linkTrim2];
            NSDate *formattedDate3 = [dateFormat2 dateFromString:linkTrim1];
            NSDate *formattedDate4 = [dateFormat2 dateFromString:linkTrim2];
            
            if(formattedDate1 != NULL)
                [item setObject:formattedDate1 forKey:@"date"];
            else if(formattedDate2 != NULL)
                [item setObject:formattedDate2 forKey:@"date"];
            else if(formattedDate3 != NULL)
                [item setObject:formattedDate3 forKey:@"date"];
            else if(formattedDate4 != NULL)
                [item setObject:formattedDate4 forKey:@"date"];
        }
        else{
            NSLog(@"Date is not empty: %@", date);
            NSString *linkTrim1 = [date stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString *linkTrim2 = [date stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            NSDate *formattedDate1 = [dateFormat dateFromString:linkTrim1];
            NSDate *formattedDate2 = [dateFormat dateFromString:linkTrim2];
            NSDate *formattedDate3 = [dateFormat2 dateFromString:linkTrim1];
            NSDate *formattedDate4 = [dateFormat2 dateFromString:linkTrim2];
            
            if(formattedDate1 != NULL)
                [item setObject:formattedDate1 forKey:@"date"];
            else if(formattedDate2 != NULL)
                [item setObject:formattedDate2 forKey:@"date"];
            else if(formattedDate3 != NULL)
                [item setObject:formattedDate3 forKey:@"date"];
            else if(formattedDate4 != NULL)
                [item setObject:formattedDate4 forKey:@"date"];
        }
        
        
        [feeder addObject:[item copy]];
        
    }
    
    //NSLog(@"title: %@", [item objectForKey:@"title"]);
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        NSLog(@"adding the string: %@", string);
        [title appendString:string];
    } else if ([element isEqualToString:@"link"]) {
        NSLog(@"adding the link: %@", string);
        [link appendString:string];
    } else if ([element isEqualToString:@"summary"]) {
        [summary appendString:string];
    }else if ([element isEqualToString:@"published"] /*|| [element isEqualToString:@"pubDate"] || [element isEqualToString:@"updated"]*/ ) {
        NSLog(@"adding the published: %@", string);
        [date appendString:string];
    }else if ([element isEqualToString:@"pubDate"]) {
        //NSLog(@"adding the pubDate: %@", string);
        [pubDate appendString:string];
    }
    else if ([element isEqualToString:@"description"]) {
        [description appendString:string];
        //NSLog(@")).. description: %@", description);
    }
    else if ([element isEqualToString:@"content"]) {
        [content appendString:string];
    }
    
    //NSLog(@"outing string: %@", string);
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    NSLog(@"--parser End");
    feeds = @[@"this",
              @"us",
              @"new you",
              @"S60",
              @"Fortwo"];
    
    //[self.tableView reloadData];
    feedCount += 1;
    
    //rearage the table - SORT BY DATE
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dates == %@",date];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey: @"date" ascending: NO];
    NSArray *sortedArray = [feeder sortedArrayUsingDescriptors: [NSMutableArray arrayWithObject:sortDescriptor]];
    
    for(NSDictionary *myX in sortedArray){
        NSLog(@"sortedarrray: %@", [myX objectForKey:@"date"]);
    }
    
    feeder = [sortedArray mutableCopy];

    
    if(feedCount == [listOfFeeds count])
        [self reloadTheTable];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        RssDetailViewController *detailViewController =
        [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *string = [feeder[indexPath.row] objectForKey: @"title"];
        
        detailViewController.passTitle = string;
        detailViewController.feederDict = feeder[indexPath.row];
    }
}



@end
