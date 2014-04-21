//
//  PageContentViewController.h
//  Intelect
//
//  Created by Recommenu on 4/5/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//- (IBAction)buttonOne:(id)sender;
//- (IBAction)buttonTwo:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonA;
- (IBAction)actionA:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonB;
- (IBAction)actionB:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *buttonC;
- (IBAction)actionC:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *buttonD;
- (IBAction)actionD:(id)sender;

@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;
@property NSInteger test;
@property NSMutableArray *testing;
@end
