//
//  WhichBillViewController.h
//  WhichBill
//
//  Created by Amar Shah on 7/7/13.
//  Copyright (c) 2013 Amar Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBItem.h"
#import "WBAnswerButton.h"
#import "ObjCMongoDB.h"

@class WhichBillViewController;

@protocol WhichBillViewControllerDelegate <NSObject>

- (void)whichBillViewController:(WhichBillViewController *)wbvc
        readyToSaveNewSession:(NSDictionary *)sessionLog;

@end

@interface WhichBillViewController : UIViewController 
{
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UILabel *costLabel;
    __weak IBOutlet UILabel *msgLabel;
    __weak IBOutlet WBAnswerButton *twentyDollarButton;
    __weak IBOutlet WBAnswerButton *tenDollarButton;
    __weak IBOutlet WBAnswerButton *fiveDollarButton;
    __weak IBOutlet WBAnswerButton *oneDollarButton;
    __weak IBOutlet UIBarButtonItem *playAgainButton;
    __weak IBOutlet UIBarButtonItem *endSessionButton;
    __weak IBOutlet UISlider *slider;
}

@property (nonatomic, weak) id<WhichBillViewControllerDelegate> delegate;
@property (nonatomic, weak) WBItem *currentItem;
@property (nonatomic, weak) WBAnswerButton *correctButton;
@property (nonatomic, strong) BSONObjectID *studentID;
@property (nonatomic, strong) NSDate *startOfSession;
@property (nonatomic, strong) NSDate *startOfRound;
@property (nonatomic, strong) NSMutableArray *roundLogs;
@property NSInteger currentRoundNumber;

- (IBAction)endSession:(id)sender;
- (IBAction)buttonPushed:(id)sender;
- (IBAction)playAgain:(id)sender;
- (void)answerCorrect;
- (void)answerIncorrect:(WBAnswerButton *)answer;
- (void)sliderChanged:(id)sender;
- (NSNumber *)secondsUsed;
- (NSNumber *)correctOnFirstTry;
- (void)logRound;

@end
