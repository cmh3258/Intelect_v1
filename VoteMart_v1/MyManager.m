//
//  MyManager.m
//  Intelect
//
//  Created by Recommenu on 4/7/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import "MyManager.h"

@implementation MyManager

@synthesize theArray, yourParty, someProperty;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static MyManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        someProperty = @"Default Property Value";
        theArray = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
        
        if([[NSUserDefaults standardUserDefaults] boolForKey:@"HasDoneQuiz"])
        {
            NSString *yoParty = [[NSUserDefaults standardUserDefaults] stringForKey:@"yourParty"];
            yourParty = yoParty;
        }
        else
        {
            yourParty = nil;
        }

    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
