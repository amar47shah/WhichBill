//
//  StudentsViewController.h
//  WhichBill
//
//  Created by Amar Shah on 11/30/13.
//  Copyright (c) 2013 Amar Shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjCMongoDB.h"

@interface StudentsViewController :
    UITableViewController

@property (strong, nonatomic) MongoConnection *conn;
@property (strong, nonatomic) NSArray *studentDocs;

- (void)loadStudentDocsForTeacherID:(BSONObjectID *)teacherID;

@end
