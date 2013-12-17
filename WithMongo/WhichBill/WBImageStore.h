//
//  WBImageStore.h
//  WhichBill
//
//  Created by Amar Shah on 7/20/13.
//  Copyright (c) 2013 Amar Shah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBImageStore : NSObject
{
    NSMutableDictionary *dictionary;
}

+ (WBImageStore *)sharedStore;
- (void)setImage:(UIImage *)i forKey:(NSString *)s;
- (UIImage *)imageForKey:(NSString *)s;

@end
