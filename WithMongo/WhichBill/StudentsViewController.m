//
//  StudentsViewController.m
//  WhichBill
//
//  Created by Amar Shah on 11/30/13.
//  Copyright (c) 2013 Amar Shah. All rights reserved.
//

#import "ObjCMongoDB.h"
#import "StudentsViewController.h"
#import "SessionsViewController.h"


@implementation StudentsViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)loadStudentDocsForTeacherID:(BSONObjectID *)teacherID
{
    if (![self conn]) return;
    
    MongoKeyedPredicate *matchTeacher = [MongoKeyedPredicate predicate];
    [matchTeacher keyPath:@"teacher_id" matches:teacherID];
    
    NSError *error = nil;
    MongoDBCollection *collection = [[self conn] collectionWithName:@"whichbill.students"];
    [self setStudentDocs:[collection findWithPredicate:matchTeacher error:&error]];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self studentDocs] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:@"UITableViewCell"];
    NSString *name = [[self studentForIndexPath:indexPath] objectForKey:@"name"];
    [[cell textLabel] setText:name];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SessionsViewController *sessionsVC = [[SessionsViewController alloc] init];
    [sessionsVC setConn:[self conn]];
    [sessionsVC setStudentID:[[self studentForIndexPath:indexPath] objectForKey:@"_id"]];
    [sessionsVC loadSessionDocs];
    [[self navigationController] pushViewController:sessionsVC animated:YES];
}

- (NSDictionary *)studentForIndexPath:(NSIndexPath *)indexPath
{
    return [BSONDecoder decodeDictionaryWithDocument:[[self studentDocs] objectAtIndex:[indexPath row]]];
}

@end
