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
    __weak IBOutlet UIButton *playAgainButton;
    __weak IBOutlet UISlider *slider;
}

@property (nonatomic, weak) WBItem *currentItem;
@property (nonatomic, weak) WBAnswerButton *correctButton;

- (IBAction)buttonPushed:(id)sender;
- (IBAction)playAgain:(id)sender;
- (void)answerCorrect;
- (void)answerIncorrect:(WBAnswerButton *)answer;
- (void)sliderChanged:(id)sender;

@end
