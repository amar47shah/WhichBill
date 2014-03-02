//
//  WBImageStoreTests.m
//  WhichBill
//
//  Created by Amar Shah on 3/2/14.
//  Copyright (c) 2014 Amar Shah. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "WBImageStore.h"

@interface WBImageStoreTests : SenTestCase
{
    WBImageStore *store;
}

@end

@implementation WBImageStoreTests

- (void)setUp
{
    [super setUp];
    store = [WBImageStore sharedStore];
}

- (void)tearDown
{
    store = nil;
    [NSThread sleepForTimeInterval:0.05];
    [super tearDown];
}

- (void)testThatImageStoreIsCreated
{
    STAssertNotNil(store, @"WBImageStore's shared store should exist");
}

- (void)testThatImageStoreIsShared
{
    WBImageStore *newStore = [WBImageStore sharedStore];
    STAssertTrue(newStore == store, @"there should be only one pointer to the shared store");
}

@end
