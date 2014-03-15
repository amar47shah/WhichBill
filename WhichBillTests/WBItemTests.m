//
//  WBItemTests.m
//  WhichBill
//
//  Created by Amar Shah on 3/1/14.
//  Copyright (c) 2014 Amar Shah. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WBItem.h"

@interface WBItemTests : XCTestCase
{
    WBItem *item;
}

@end

@implementation WBItemTests

- (void)setUp
{
    [super setUp];
    item = [[WBItem alloc] initWithName:@"Test" costMin:0.0 costMax:20.0];

}

- (void)tearDown
{
    item = nil;
    [super tearDown];
}

- (void)testThatWBItemExists
{
    XCTAssertNotNil(item, @"should be able to create WBItem instance.");
}

- (void)testThatWBItemCanBeNamed
{
    XCTAssertEqualObjects([item name], @"Test", @"the WBItem should have the name I gave it");
}

- (void)testThatWBItemImageKeyIsCreated
{
    XCTAssertNotNil([item imageKey], @"the WBItem's imageKey should be generated on init");
}

- (void)testThatWBItemCostIsWithinRange
{
    XCTAssertTrue([item cost] >= 0.0, @"the WBItem's cost must be at least as big as the minimum specified");
    XCTAssertTrue([item cost] <= 20.0, @"the WBItem's cost must be no greater than the maximum specified");
}

- (void)testThatWBItemCostCanBeChanged
{
    double oldCost = [item cost];
    [item setCost];
    XCTAssertFalse([item cost] == oldCost, @"the WBItem's cost should change when it is sent setCost message");
}

- (void)testThatWBItemCostMinAndCostMaxCanBeChanged
{
    [item setCostMin:30.0];
    [item setCostMax:40.0];
    [item setCost];
    XCTAssertTrue([item cost] >= 30.0, @"the WBItem's cost must be at least as big as the minimum specified");
    XCTAssertTrue([item cost] <= 40.0, @"the WBItem's cost must be no greater than the maximum specified");
    [item setCostMin:0.0];
    [item setCostMax:20.0];
}

@end
