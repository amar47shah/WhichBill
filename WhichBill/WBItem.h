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
    double costMin;
    double costMax;
    double cost;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, copy) NSString *imageKey;

- (id)initWithName:(NSString *)n costMin:(double)cMin costMax:(double)cMax;
- (double)cost;
- (void)setCostMin:(double)cMin;
- (void)setCostMax:(double)cMax;
- (void)setCost;

@end
