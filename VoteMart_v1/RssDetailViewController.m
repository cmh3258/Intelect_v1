//
//  RssDetailViewController.m
//  VoteMart_v1
//
//  Created by Recommenu on 3/25/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import "RssDetailViewController.h"

@interface RssDetailViewController ()

@end

@implementation RssDetailViewController
//@synthesize passTitle = _passTitle;

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
    NSLog(@"passtitle: %@", _passTitle);
    
    NSString *rssUrl = [_feederDict objectForKey:@"link"];
    NSLog(@"url:%@.", rssUrl);
    
    NSString *probablyEmpty = [rssUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [probablyEmpty stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    BOOL wereOnlySpaces = [probablyEmpty isEqualToString:@""];
    
    NSLog(@"bool: %hhd", wereOnlySpaces);
    NSLog(@"probempty:%@.", probablyEmpty);
     NSLog(@"probempty:%i.", [probablyEmpty length]);
    
    if([probablyEmpty length]<2 || [rssUrl isEqual: @" "]){
        NSLog(@"webview should be hidden");
        self.RssWebView.hidden = YES;
        self.rssTitle.text = [_feederDict objectForKey:@"title"];
        self.rssContent.text = [_feederDict objectForKey:@"content"];
    }
    else{
    
        NSURL *myURL = [NSURL URLWithString: [rssUrl stringByAddingPercentEscapesUsingEncoding:
                                          NSUTF8StringEncoding]];
        NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
        [self.RssWebView loadRequest:request];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
