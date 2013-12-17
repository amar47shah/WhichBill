//
//  SessionsViewController.m
//  WhichBill
//
//  Created by Amar Shah on 12/5/13.
//  Copyright (c) 2013 Amar Shah. All rights reserved.
//

#import "ObjCMongoDB.h"
#import "SessionsViewController.h"
#import "WhichBillViewController.h"

@interface SessionsViewController ()

@end

@implementation SessionsViewController

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

- (void)loadSessionDocs
{
    if (![self conn]) return;
    if (![self studentID]) return;
    
    MongoKeyedPredicate *matchStudent = [MongoKeyedPredicate predicate];
    [matchStudent keyPath:@"student_id" matches:[self studentID]];
    
    NSError *error = nil;
    MongoDBCollection *collection = [[self conn] collectionWithName:@"whichbill.sessions"];
    [self setSessionDocs:[collection findWithPredicate:matchStudent error:&error]];
    
}

- (UIView *)documentView
{
    if (!documentView)
    {
        [[NSBundle mainBundle] loadNibNamed:@"DocumentView" owner:self options:nil];
    }
    return documentView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self documentView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [[self documentView] bounds].size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self sessionDocs] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];

    NSString *dateAndTime = [[self sessionForIndexPath:indexPath] objectForKey:@"date_time"];
    [[cell textLabel] setText:dateAndTime];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [sessionText setText:[NSString stringWithFormat:@"%@",[self sessionForIndexPath:indexPath]]];
    //NSLog([NSString stringWithFormat:@"%@",[self sessionForIndexPath:indexPath]]);
}

- (NSDictionary *)sessionForIndexPath:(NSIndexPath *)indexPath
{
    return [BSONDecoder decodeDictionaryWithDocument:[[self sessionDocs] objectAtIndex:[indexPath row]]];
}

- (IBAction)startNewSession:(id)sender
{
    WhichBillViewController *wbvc = [[WhichBillViewController alloc] initWithNibName:@"WhichBillViewController" bundle:nil];
    [wbvc setDelegate:self];
    [wbvc setStudentID:[self studentID]];
    [[self navigationController] pushViewController:wbvc animated:YES];
}

- (void)whichBillViewController:(WhichBillViewController *)wbvc
          readyToSaveNewSession:(NSDictionary *)sessionLog
{
    NSLog(@"%@", sessionLog);
    NSError *error = nil;
    MongoDBCollection *collection = [[self conn] collectionWithName:@"whichbill.sessions"];
    BSONDocument *newSessionDoc = [BSONEncoder documentForDictionary:sessionLog];
    [collection insertDocument:newSessionDoc writeConcern:nil error:&error];

    // Add document to sessionDocs array:
    [self setSessionDocs:[[self sessionDocs] arrayByAddingObject:newSessionDoc]];
    
    // New row in table
    NSInteger newRow = [[self sessionDocs] indexOfObject:newSessionDoc];
    NSIndexPath *ip = [NSIndexPath indexPathForRow:newRow inSection:0];
    [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:ip]
                                                    withRowAnimation:UITableViewRowAnimationTop];
    
}

@end
