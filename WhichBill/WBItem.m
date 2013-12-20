//
//  WBItem.m
//  WhichBill
//
//  Created by Amar Shah on 7/20/13.
//  Copyright (c) 2013 Amar Shah. All rights reserved.
//

#import "WBItem.h"
#include <stdlib.h>
#define ARC4RANDOM_MAX 0x100000000

@implementation WBItem

@synthesize name, imageKey;

- (id)init
{
    return [self initWithName:@"Item" costMin:0.0 costMax:0.0];
}


- (id) initWithName:(NSString *)n costMin:(double)cMin costMax:(double)cMax
{
    self = [super init];
    if (self)
    {
        srand(time(NULL));
        
        CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
        CFStringRef newUniqueIDString = CFUUIDCreateString (kCFAllocatorDefault, newUniqueID);
        
        NSString *key = (__bridge NSString *)newUniqueIDString;
        [self setImageKey:key];
        
        // release core foundation memory
        CFRelease(newUniqueIDString);
        CFRelease(newUniqueID);
        
        [self setName:n];
        [self setCostMin:cMin];
        [self setCostMax:cMax];
        [self setCost];
    }
    return self;
}

- (void)setCostMin:(double)cMin
{
    costMin = cMin;
}

- (void)setCostMax:(double)cMax
{
    costMax = cMax;
}


- (double)cost
{
    return cost;
}

- (void)setCost
{
    double range = fabs(costMax - costMin);
    
    cost = ((double)arc4random() / ARC4RANDOM_MAX) * range + costMin;
}

@end
