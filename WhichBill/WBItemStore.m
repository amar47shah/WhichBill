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
        WBItem *wb1 = [[WBItem alloc] initWithName:@"Apples" costMin:1.5 costMax:2.5];
        WBItem *wb2 = [[WBItem alloc] initWithName:@"Roach Poison" costMin:8.0 costMax:12.0];
        WBItem *wb3 = [[WBItem alloc] initWithName:@"Grapefruit" costMin:0.70 costMax:1.4];
        WBItem *wb4 = [[WBItem alloc] initWithName:@"Peanut Butter" costMin:0.90 costMax:3.0];
        WBItem *wb5 = [[WBItem alloc] initWithName:@"Chicken Wings" costMin:4.5 costMax:7.0];
        WBItem *wb6 = [[WBItem alloc] initWithName:@"Bologna" costMin:2.0 costMax:3.5];
        WBItem *wb7 = [[WBItem alloc] initWithName:@"Batteries" costMin:8.0 costMax:14.0];
        WBItem *wb8 = [[WBItem alloc] initWithName:@"Serrano Peppers" costMin:0.40 costMax:1.1];
        WBItem *wb9 = [[WBItem alloc] initWithName:@"Strawberry Jam" costMin:0.90 costMax:4.20];
        WBItem *wb10= [[WBItem alloc] initWithName:@"Wheat Bread" costMin:1.4 costMax:4.1];
        
        allItems = [[NSArray alloc] initWithObjects:
                    wb1, wb2, wb3, wb4, wb5, wb6, wb7, wb8, wb9, wb10, nil];
        
        // add images to Image Store
        NSString *file1 = [[NSBundle mainBundle] pathForResource:@"IMG_4075" ofType:@"jpg"];
        UIImage *img1 = [UIImage imageWithContentsOfFile:file1];
        if (img1) [[WBImageStore sharedStore] setImage:img1  forKey:[wb1  imageKey]]; else NSLog(@"Nil img1");

        NSString *file2 = [[NSBundle mainBundle] pathForResource:@"IMG_4120" ofType:@"jpg"];
        UIImage *img2 = [UIImage imageWithContentsOfFile:file2];
        if (img2) [[WBImageStore sharedStore] setImage:img2  forKey:[wb2  imageKey]]; else NSLog(@"Nil img2");

        NSString *file3 = [[NSBundle mainBundle] pathForResource:@"IMG_4076" ofType:@"jpg"];
        UIImage *img3 = [UIImage imageWithContentsOfFile:file3];
        if (img3) [[WBImageStore sharedStore] setImage:img3  forKey:[wb3  imageKey]]; else NSLog(@"Nil img3");

        NSString *file4 = [[NSBundle mainBundle] pathForResource:@"IMG_4100" ofType:@"jpg"];
        UIImage *img4 = [UIImage imageWithContentsOfFile:file4];
        if (img4) [[WBImageStore sharedStore] setImage:img4  forKey:[wb4  imageKey]]; else NSLog(@"Nil img4");
        
        NSString *file5 = [[NSBundle mainBundle] pathForResource:@"IMG_4107" ofType:@"jpg"];
        UIImage *img5 = [UIImage imageWithContentsOfFile:file5];
        if (img5) [[WBImageStore sharedStore] setImage:img5  forKey:[wb5  imageKey]]; else NSLog(@"Nil img5");
        
        NSString *file6 = [[NSBundle mainBundle] pathForResource:@"IMG_4124" ofType:@"jpg"];
        UIImage *img6 = [UIImage imageWithContentsOfFile:file6];
        if (img6) [[WBImageStore sharedStore] setImage:img6  forKey:[wb6  imageKey]]; else NSLog(@"Nil img6");
        
        NSString *file7 = [[NSBundle mainBundle] pathForResource:@"IMG_4114" ofType:@"jpg"];
        UIImage *img7 = [UIImage imageWithContentsOfFile:file7];
        if (img7) [[WBImageStore sharedStore] setImage:img7  forKey:[wb7  imageKey]]; else NSLog(@"Nil img7");
        
        NSString *file8 = [[NSBundle mainBundle] pathForResource:@"IMG_4090" ofType:@"jpg"];
        UIImage *img8 = [UIImage imageWithContentsOfFile:file8];
        if (img8) [[WBImageStore sharedStore] setImage:img8  forKey:[wb8  imageKey]]; else NSLog(@"Nil img8");
        
        NSString *file9 = [[NSBundle mainBundle] pathForResource:@"IMG_4099" ofType:@"jpg"];
        UIImage *img9 = [UIImage imageWithContentsOfFile:file9];
        if (img9) [[WBImageStore sharedStore] setImage:img9  forKey:[wb9  imageKey]]; else NSLog(@"Nil img9");
        
        NSString *file10 = [[NSBundle mainBundle] pathForResource:@"IMG_4095" ofType:@"jpg"];
        UIImage *img10= [UIImage imageWithContentsOfFile:file10];
        if (img10) [[WBImageStore sharedStore] setImage:img10 forKey:[wb10 imageKey]]; else NSLog(@"Nil img10");
    }
    return self;
}

- (NSArray *)allItems
{
    return allItems;
}

@end
