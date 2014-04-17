//
//  QuizViewController.h
//  Intelect
//
//  Created by Recommenu on 4/5/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface QuizViewController : UIViewController <UIPageViewControllerDataSource, UIAlertViewDelegate>

//- (IBAction)startWalk:(id)sender;
//- (IBAction)startWalker:(id)sender;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;

@end
