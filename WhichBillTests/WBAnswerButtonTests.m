//
//  WBAnswerButtonTests.m
//  WhichBill
//
//  Created by Amar Shah on 3/2/14.
//  Copyright (c) 2014 Amar Shah. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WBAnswerButton.h"

@interface WBAnswerButtonTests : XCTestCase
{
    WBAnswerButton *button;
}

@end

@implementation WBAnswerButtonTests

- (void)setUp
{
    [super setUp];
    button = [[WBAnswerButton alloc] init];
}

- (void)tearDown
{
    button = nil;
    [super tearDown];
}

- (void)testThatAlreadyGuessedWrongStartsFalse
{
    XCTAssertFalse([button alreadyGuessedWrong], @"alreadyGuessedWrong should start out False.");
}

- (void)testThatAlreadyGuessedWrongValueCanBeChangedToTrue
{
    [button setAlreadyGuessedWrong:YES];
    XCTAssertTrue([button alreadyGuessedWrong], @"should be able to set alreadyGuessedWrong to True");
}

@end
