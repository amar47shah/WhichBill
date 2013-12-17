//
//  TeachersViewController.m
//  WhichBill
//
//  Created by Amar Shah on 11/29/13.
//  Copyright (c) 2013 Amar Shah. All rights reserved.
//

#import "StudentsViewController.h"
#import "TeachersViewController.h"
#import "ObjCMongoDB.h"

@implementation TeachersViewController

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

- (void)loadTeacherDocs
{
    if (![self conn]) return;
    
    NSError *error = nil;
    MongoDBCollection *collection = [[self conn] collectionWithName:@"whichbill.teachers"];
    [self setTeacherDocs:[collection findAllWithError:&error]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self teacherDocs] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:@"UITableViewCell"];
    NSString *username = [[self teacherForIndexPath:indexPath] objectForKey:@"username"];
    [[cell textLabel] setText: username];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudentsViewController *svc = [[StudentsViewController alloc] init];
    [svc setConn:[self conn]];
    [svc loadStudentDocsForTeacherID:[[self teacherForIndexPath:indexPath] objectForKey:@"_id"]];
    [[self navigationController] pushViewController:svc animated:YES];
}

- (NSDictionary *)teacherForIndexPath:(NSIndexPath *)indexPath
{
    return [BSONDecoder decodeDictionaryWithDocument:[[self teacherDocs] objectAtIndex:[indexPath row]]];
}

@end
