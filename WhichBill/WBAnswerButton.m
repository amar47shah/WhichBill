//
//  WBAnswerButton.m
//  WhichBill
//
//  Created by Amar Shah on 7/22/13.
//  Copyright (c) 2013 Amar Shah. All rights reserved.
//

#import "WBAnswerButton.h"

@implementation WBAnswerButton

@synthesize alreadyGuessedWrong;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setAlreadyGuessedWrong:NO];
    }
    return self;
}

@end
