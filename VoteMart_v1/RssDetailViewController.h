//
//  RssDetailViewController.h
//  Intelect_v1
//
//  Created by Recommenu on 3/25/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RssDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *rssTitle;
@property (weak, nonatomic) IBOutlet UILabel *rssContent;

@property (strong, nonatomic) NSString *passTitle;
@property (weak, nonatomic) IBOutlet UIWebView *RssWebView;
@property (strong, nonatomic) NSMutableDictionary *feederDict;
@end
