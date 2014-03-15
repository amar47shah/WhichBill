//
//  WBImageStoreTests.m
//  WhichBill
//
//  Created by Amar Shah on 3/2/14.
//  Copyright (c) 2014 Amar Shah. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WBImageStore.h"

@interface WBImageStoreTests : XCTestCase
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
    [super tearDown];
}

- (void)testThatImageStoreIsCreated
{
    XCTAssertNotNil(store, @"WBImageStore's shared store should exist");
}

- (void)testThatImageStoreIsShared
{
    WBImageStore *newStore = [WBImageStore sharedStore];
    XCTAssertTrue(newStore == store, @"there should be only one pointer to the shared store");
}

@end
