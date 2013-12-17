//
//  TeachersViewController.h
//  WhichBill
//
//  Created by Amar Shah on 11/29/13.
//  Copyright (c) 2013 Amar Shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjCMongoDB.h"

@interface TeachersViewController : UITableViewController

@property (strong, nonatomic) MongoConnection *conn;
@property (strong, nonatomic) NSArray *teacherDocs;

- (void)loadTeacherDocs;

@end
