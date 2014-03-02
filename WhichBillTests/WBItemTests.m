//
//  WBItemTests.m
//  WhichBill
//
//  Created by Amar Shah on 3/1/14.
//  Copyright (c) 2014 Amar Shah. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "WBItem.h"

@interface WBItemTests : SenTestCase
{
    WBItem *item;
}

@end

@implementation WBItemTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    item = [[WBItem alloc] initWithName:@"Test" costMin:0.0 costMax:20.0];

}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testThatWBItemExists
{
    STAssertNotNil(item, @"should be able to create WBItem instance.");
}

- (void)testThatWBItemCanBeNamed
{
    STAssertEqualObjects([item name], @"Test", @"the WBItem should have the name I gave it");
}

- (void)testThatWBItemImageKeyIsCreated
{
    STAssertNotNil([item imageKey], @"the WBItem's imageKey should be generated on init");
}

- (void)testThatWBItemCostIsWithinRange
{
    STAssertTrue([item cost] >= 0.0, @"the WBItem's cost must be at least as big as the minimum specified");
    STAssertTrue([item cost] <= 20.0, @"the WBItem's cost must be no greater than the maximum specified");
}

- (void)testThatWBItemCostCanBeChanged
{
    double oldCost = [item cost];
    [item setCost];
    STAssertFalse([item cost] == oldCost, @"the WBItem's cost should change when it is sent setCost message");
}



@end
