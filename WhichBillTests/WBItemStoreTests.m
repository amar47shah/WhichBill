//
//  WBItemStoreTests.m
//  WhichBill
//
//  Created by Amar Shah on 3/2/14.
//  Copyright (c) 2014 Amar Shah. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "WBItemStore.h"
#import "WBImageStore.h"
#import "WBItem.h"

@interface WBItemStoreTests : SenTestCase
{
    WBItemStore *store;
}

@end

@implementation WBItemStoreTests

- (void)setUp
{
    [super setUp];
    store = [WBItemStore sharedStore];
}

- (void)tearDown
{
    store = nil;
    [NSThread sleepForTimeInterval:0.08];
    [super tearDown];
}

- (void)testThatSharedStoreIsCreated
{
    STAssertNotNil(store, @"WBItemStore's sharedstore should exist");
}

- (void)testThatSameSharedStoreIsUsed
{
    WBItemStore *newStore = [WBItemStore sharedStore];
    STAssertTrue(newStore == store, @"the new sharedStore should be the same as the old one");
}

- (void)testThatAllItemsArrayIsCreated
{
    STAssertNotNil([store allItems], @"allItems should exist");
}

- (void)testThatAllItemsArrayIsNotEmpty
{
    STAssertFalse([[store allItems] count] == 0, @"allItems should not be empty");
}

- (void)testThatImageStoredForEachItem
{
    WBImageStore *imgStore = [WBImageStore sharedStore];
    for (WBItem *i in [store allItems])
    {
        STAssertNotNil([imgStore imageForKey:[i imageKey]], @"each item in allItems should have an image in the image store");
    }
}
@end
