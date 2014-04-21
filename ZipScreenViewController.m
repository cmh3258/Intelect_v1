//
//  ZipScreenViewController.m
//  Intelect
//
//  Created by Recommenu on 4/9/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import "ZipScreenViewController.h"

@interface ZipScreenViewController ()

@end

@implementation ZipScreenViewController
@synthesize zipEnter;

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
    
    [self.navigationController setNavigationBarHidden:YES];
    
    self.zipMessage.font = [UIFont fontWithName:@"PTSans-Bold" size:16];
    self.zipMessage.text = @"Enter your zip code";
    
    [self.enterZipField becomeFirstResponder];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    numberToolbar.barTintColor = [UIColor darkGrayColor];
    numberToolbar.tintColor = [UIColor colorWithRed:(37/256.0) green:(236/256.0) blue:(110/256.0) alpha:(1.0)];
    [numberToolbar sizeToFit];
    self.enterZipField.inputAccessoryView = numberToolbar;
}

-(void)doneWithNumberPad{
    NSLog(@"You entered %@",self.enterZipField.text);
    if([self.enterZipField.text length] > 4)
    {
        [self.enterZipField resignFirstResponder];
    
        [[NSUserDefaults standardUserDefaults] setObject:self.enterZipField.text forKey:@"zipCode"];
        [self changeScreen];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"You entered %@",self.enterZipField.text);
    [self.enterZipField resignFirstResponder];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.enterZipField.text forKey:@"zipCode"];
    [self changeScreen];
    return YES;
}

-(void) changeScreen
{
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"rssFeed"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
