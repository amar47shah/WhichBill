//
//  WBItem.h
//  WhichBill
//
//  Created by Amar Shah on 7/20/13.
//  Copyright (c) 2013 Amar Shah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBItem : NSObject
{
    double cost;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, copy) NSString *imageKey;

- (id)initWithName:(NSString *)n cost:(double)c;
- (double)cost;
- (void)setCost:(double)c;

@end
