//
//  WBItem.m
//  WhichBill
//
//  Created by Amar Shah on 7/20/13.
//  Copyright (c) 2013 Amar Shah. All rights reserved.
//

#import "WBItem.h"

@implementation WBItem

@synthesize name, imageKey;

- (id)init
{
    return [self initWithName:@"Item" cost:0.0];
}


- (id) initWithName:(NSString *)n cost:(double)c
{
    self = [super init];
    if (self)
    {
        CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
        CFStringRef newUniqueIDString = CFUUIDCreateString (kCFAllocatorDefault, newUniqueID);
        
        NSString *key = (__bridge NSString *)newUniqueIDString;
        [self setImageKey:key];
        
        // release core foundation memory
        CFRelease(newUniqueIDString);
        CFRelease(newUniqueID);
        
        [self setName:n];
        [self setCost:c];
    }
    return self;
}

- (double)cost
{
    return cost;
}

- (void)setCost:(double)c
{
    cost = c;
}

@end
