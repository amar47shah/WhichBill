//
//  WBAnswerButtonTests.m
//  WhichBill
//
//  Created by Amar Shah on 3/2/14.
//  Copyright (c) 2014 Amar Shah. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "WBAnswerButton.h"

@interface WBAnswerButtonTests : SenTestCase
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
    [NSThread sleepForTimeInterval:0.05];
    [super tearDown];
}

- (void)testThatAlreadyGuessedWrongStartsFalse
{
    STAssertFalse([button alreadyGuessedWrong], @"alreadyGuessedWrong should start out False.");
}

- (void)testThatAlreadyGuessedWrongValueCanBeChangedToTrue
{
    [button setAlreadyGuessedWrong:YES];
    STAssertTrue([button alreadyGuessedWrong], @"should be able to set alreadyGuessedWrong to True");
}

@end
