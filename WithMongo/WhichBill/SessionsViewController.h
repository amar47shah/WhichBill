//
//  SessionsViewController.h
//  WhichBill
//
//  Created by Amar Shah on 12/5/13.
//  Copyright (c) 2013 Amar Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjCMongoDB.h"
#import "WhichBillViewController.h"

@interface SessionsViewController : UITableViewController <WhichBillViewControllerDelegate>
{
    IBOutlet UIView *documentView;
    __weak IBOutlet UITextView *sessionText;
}

@property (strong, nonatomic) MongoConnection *conn;
@property (strong, nonatomic) NSArray *sessionDocs;
@property (strong, nonatomic) BSONObjectID *studentID;

- (void)loadSessionDocs;
- (UIView *)documentView;
- (IBAction)startNewSession:(id)sender;

@end
