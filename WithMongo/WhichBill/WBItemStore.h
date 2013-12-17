//
//  WBItemStore.h
//  WhichBill
//
//  Created by Amar Shah on 7/20/13.
//  Copyright (c) 2013 Amar Shah. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBItem;

@interface WBItemStore : NSObject
{
    NSArray *allItems;
}

+ (WBItemStore *)sharedStore;
- (NSArray *)allItems;

@end
