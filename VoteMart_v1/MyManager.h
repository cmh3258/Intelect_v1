//
//  MyManager.h
//  Intelect
//
//  Created by Recommenu on 4/7/14.
//  Copyright (c) 2014 YeddieJones. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyManager : NSObject{
    NSString *someProperty;
    NSMutableArray *theArray;
}

@property (nonatomic, retain) NSString *someProperty;
@property (nonatomic, retain) NSMutableArray *theArray;
@property (nonatomic, retain) NSString *yourParty;

+ (id)sharedManager;

@end

