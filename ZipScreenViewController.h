//
//  ZipScreenViewController.h
//  Intelect
//
//  Created by Recommenu on 4/9/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZipScreenViewController : UIViewController<UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *zipEnter;
@property (weak, nonatomic) IBOutlet UILabel *zipMessage;
//- (IBAction)zipCode:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *enterZipField;
@end
