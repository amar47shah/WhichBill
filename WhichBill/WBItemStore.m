//
//  WBItemStore.m
//  WhichBill
//
//  Created by Amar Shah on 7/20/13.
//  Copyright (c) 2013 Amar Shah. All rights reserved.
//

#import "WBItem.h"
#import "WBItemStore.h"
#import "WBImageStore.h"

@implementation WBItemStore

+ (WBItemStore *)sharedStore
{
    static WBItemStore *sharedStore = nil;
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    
    return sharedStore;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        // add items to Item Store
        allItems = [[NSArray alloc] initWithObjects:
                    [[WBItem alloc] initWithName:@"Apples"            costMin:1.5 costMax:2.5],
                    [[WBItem alloc] initWithName:@"Batteries"         costMin:8.0 costMax:14.0],
                    [[WBItem alloc] initWithName:@"Bologna"           costMin:2.0 costMax:3.5],
                    [[WBItem alloc] initWithName:@"Chicken Wings"     costMin:4.5 costMax:7.0],
                    [[WBItem alloc] initWithName:@"Grapefruit"        costMin:0.7 costMax:1.4],
                    [[WBItem alloc] initWithName:@"Peanut Butter"     costMin:0.9 costMax:3.0],
                    [[WBItem alloc] initWithName:@"Roach Poison"      costMin:8.0 costMax:12.0],
                    [[WBItem alloc] initWithName:@"Serrano Peppers"   costMin:0.4 costMax:1.1],
                    [[WBItem alloc] initWithName:@"Strawberry Jam"    costMin:0.9 costMax:4.2],
                    [[WBItem alloc] initWithName:@"Wheat Bread"       costMin:1.4 costMax:4.1],
                    nil];
        
        // add images to Image Store
        for (WBItem *item in allItems)
        {
            NSString *file = [[NSBundle mainBundle] pathForResource:[item name] ofType:@"jpg"];
            UIImage *img = [UIImage imageWithContentsOfFile:file];
            if (img) [[WBImageStore sharedStore] setImage:img forKey:[item imageKey]]; else NSLog(@"Nil %@", [item name]);
        }
    }
    return self;
}

- (NSArray *)allItems
{
    return allItems;
}

@end
