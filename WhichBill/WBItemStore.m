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
                    [[WBItem alloc] initWithName:@"Apple Juice"         costMin:4.5 costMax: 6.5],
                    [[WBItem alloc] initWithName:@"Apples"              costMin:0.5 costMax: 1.5],
                    [[WBItem alloc] initWithName:@"Avocados"            costMin:3.0 costMax: 6.0],
                    [[WBItem alloc] initWithName:@"Bananas"             costMin:0.6 costMax: 1.4],
                    [[WBItem alloc] initWithName:@"Batteries"           costMin:8.0 costMax:14.0],
                    [[WBItem alloc] initWithName:@"Bell Peppers"        costMin:0.4 costMax: 1.2],
                    [[WBItem alloc] initWithName:@"Bologna"             costMin:0.8 costMax: 2.0],
                    [[WBItem alloc] initWithName:@"Broccoli"            costMin:0.4 costMax: 1.3],
                    [[WBItem alloc] initWithName:@"Chicken Noodle Soup" costMin:0.5 costMax: 2.0],
                    [[WBItem alloc] initWithName:@"Chicken Wings"       costMin:4.5 costMax: 7.0],
                    [[WBItem alloc] initWithName:@"Coconuts"            costMin:4.0 costMax: 7.0],
                    [[WBItem alloc] initWithName:@"Cookies"             costMin:2.0 costMax: 3.5],
                    [[WBItem alloc] initWithName:@"Corn Flakes"         costMin:4.0 costMax: 5.5],
                    [[WBItem alloc] initWithName:@"Crackers"            costMin:0.5 costMax: 1.2],
                    [[WBItem alloc] initWithName:@"Cream Cheese"        costMin:1.5 costMax: 3.5],
                    [[WBItem alloc] initWithName:@"Cucumbers"           costMin:0.5 costMax: 1.2],
                    [[WBItem alloc] initWithName:@"Dish Soap"           costMin:4.5 costMax: 6.5],
                    [[WBItem alloc] initWithName:@"Eggplant"            costMin:0.5 costMax: 1.3],
                    [[WBItem alloc] initWithName:@"Frozen French Fries" costMin:4.5 costMax: 7.0],
                    [[WBItem alloc] initWithName:@"Frozen Vegetables"   costMin:2.0 costMax: 4.0],
                    [[WBItem alloc] initWithName:@"Ginger"              costMin:0.4 costMax: 1.1],
                    [[WBItem alloc] initWithName:@"Graham Crackers"     costMin:0.8 costMax: 3.3],
                    [[WBItem alloc] initWithName:@"Grapefruit"          costMin:0.6 costMax: 1.4],
                    [[WBItem alloc] initWithName:@"Grapes"              costMin:2.5 costMax: 7.0],
                    [[WBItem alloc] initWithName:@"Ground Pork"         costMin:4.0 costMax: 8.0],
                    [[WBItem alloc] initWithName:@"Hamburger Patties"   costMin:5.0 costMax:11.0],
                    [[WBItem alloc] initWithName:@"Honey"               costMin:4.0 costMax: 6.0],
                    [[WBItem alloc] initWithName:@"Hot Dog Buns"        costMin:0.8 costMax: 1.2],
                    [[WBItem alloc] initWithName:@"Hot Dogs"            costMin:4.0 costMax: 6.0],
                    [[WBItem alloc] initWithName:@"Ice Cream"           costMin:3.5 costMax: 6.5],
                    [[WBItem alloc] initWithName:@"Ketchup"             costMin:2.0 costMax: 4.0],
                    [[WBItem alloc] initWithName:@"Lasagna"             costMin:7.0 costMax:14.0],
                    [[WBItem alloc] initWithName:@"Laundry Detergent"   costMin:4.0 costMax: 6.0],
                    [[WBItem alloc] initWithName:@"Lemons"              costMin:0.6 costMax: 1.3],
                    [[WBItem alloc] initWithName:@"Limes"               costMin:0.4 costMax: 1.3],
                    [[WBItem alloc] initWithName:@"Mayonnaise"          costMin:0.8 costMax: 4.0],
                    [[WBItem alloc] initWithName:@"Oatmeal"             costMin:0.8 costMax: 4.0],
                    [[WBItem alloc] initWithName:@"Onion"               costMin:0.5 costMax: 1.1],
                    [[WBItem alloc] initWithName:@"Pancake Mix"         costMin:0.9 costMax: 2.5],
                    [[WBItem alloc] initWithName:@"Peanut Butter"       costMin:0.9 costMax: 3.0],
                    [[WBItem alloc] initWithName:@"Pears"               costMin:0.7 costMax: 2.4],
                    [[WBItem alloc] initWithName:@"Pineapple"           costMin:3.9 costMax: 6.5],
                    [[WBItem alloc] initWithName:@"Potato Chips"        costMin:0.7 costMax: 2.0],
                    [[WBItem alloc] initWithName:@"Roach Poison"        costMin:8.0 costMax:12.0],
                    [[WBItem alloc] initWithName:@"Salad Dressing"      costMin:1.5 costMax: 3.5],
                    [[WBItem alloc] initWithName:@"Sausage Muffins"     costMin:4.0 costMax: 6.0],
                    [[WBItem alloc] initWithName:@"Serrano Peppers"     costMin:0.4 costMax: 1.1],
                    [[WBItem alloc] initWithName:@"Sliced Cheese"       costMin:1.4 costMax: 5.2],
                    [[WBItem alloc] initWithName:@"Soda 2-Liter"        costMin:0.9 costMax: 2.2],
                    [[WBItem alloc] initWithName:@"Spaghetti Sauce"     costMin:0.8 costMax: 3.0],
                    [[WBItem alloc] initWithName:@"Spaghetti"           costMin:0.6 costMax: 3.0],
                    [[WBItem alloc] initWithName:@"Sponges"             costMin:3.5 costMax: 5.5],
                    [[WBItem alloc] initWithName:@"Steaks"              costMin:9.0 costMax:16.0],
                    [[WBItem alloc] initWithName:@"Strawberries"        costMin:2.0 costMax: 4.5],
                    [[WBItem alloc] initWithName:@"Strawberry Jam"      costMin:0.9 costMax: 4.2],
                    [[WBItem alloc] initWithName:@"String Cheese"       costMin:4.4 costMax: 5.9],
                    [[WBItem alloc] initWithName:@"Tortilla Chips"      costMin:0.7 costMax: 3.4],
                    [[WBItem alloc] initWithName:@"Wheat Bread"         costMin:1.4 costMax: 4.1],
                    nil];
        
        // add images to Image Store
        for (WBItem *item in allItems)
        {
            NSString *file = [[NSBundle mainBundle] pathForResource:[item name] ofType:@"jpg"];
            UIImage *img = [UIImage imageWithContentsOfFile:file];
            if (img)
                [[WBImageStore sharedStore] setImage:img forKey:[item imageKey]];
            else
                NSLog(@"Nil %@", [item name]);
        }
    }
    return self;
}

- (NSArray *)allItems
{
    return allItems;
}

@end
