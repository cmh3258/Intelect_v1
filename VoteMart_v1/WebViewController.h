//
//  WebViewController.h
//  Intelect
//
//  Created by Recommenu on 4/15/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *govView;
@property (weak, nonatomic) NSString *registrationURL;
@property BOOL regHasURL;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@end
