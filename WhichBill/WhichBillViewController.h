//
//  WhichBillViewController.h
//  WhichBill
//
//  Created by Amar Shah on 7/7/13.
//  Copyright (c) 2013 Amar Shah. All rights reserved.
//

#include <AudioToolbox/AudioToolbox.h>
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
    
    UIPopoverController *instructionsPopover;    
    SystemSoundID soundCorrect;
    SystemSoundID soundIncorrect;
    SystemSoundID soundStart;
    BOOL soundsLoaded;
}

@property (nonatomic, weak) WBItem *currentItem;
@property (nonatomic, weak) WBAnswerButton *correctButton;
@property (readonly) SystemSoundID soundCorrect;
@property (readonly) SystemSoundID soundIncorrect;
@property (readonly) SystemSoundID soundStart;

- (IBAction)buttonPushed:(id)sender;
- (IBAction)playAgain:(id)sender;
- (IBAction)showInstructions:(id)sender;
- (void)answerCorrect;
- (void)answerIncorrect:(WBAnswerButton *)answer;
- (void)sliderChanged:(id)sender;

@end
