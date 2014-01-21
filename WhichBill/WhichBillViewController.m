//
//  WhichBillViewController.m
//  WhichBill
//
//  Created by Amar Shah on 7/7/13.
//  Copyright (c) 2013 Amar Shah. All rights reserved.
//

#include <stdlib.h>
#include <AudioToolbox/AudioToolbox.h>
#import "InstructionsViewController.h"
#import "WhichBillViewController.h"
#import "WBItem.h"
#import "WBItemStore.h"
#import "WBImageStore.h"
#import "WBAnswerButton.h"
#define VERBOSE 0

@implementation WhichBillViewController

@synthesize currentItem, correctButton;
@synthesize soundFileObject;

- (void)viewDidLoad
{
    [super viewDidLoad];
       // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *items = [[WBItemStore sharedStore] allItems];
    
    if (VERBOSE)
    {
        for (WBItem *item in items)
        {
            NSLog(@"%@", [item name]);
            NSLog(@"%f", [item cost]);
            NSLog(@"%@", [item imageKey]);
            if ([[WBImageStore sharedStore] imageForKey:[item imageKey]])
                NSLog(@"Image Found.");
            else
                NSLog(@"Image Not Found.");
        }
    }

    
    [[self view] setBackgroundColor:[UIColor colorWithRed:0.875 green:0.88 blue:0.91 alpha:1]];
    
    UIImage *twentyDollarImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Dollar20" ofType:@"jpg"]];
    [twentyDollarButton setBackgroundImage:twentyDollarImage forState:UIControlStateNormal];
    [twentyDollarButton setTag:20];
    
    UIImage *tenDollarImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Dollar10" ofType:@"jpg"]];
    [tenDollarButton setBackgroundImage:tenDollarImage forState:UIControlStateNormal];
    [tenDollarButton setTag:10];

    UIImage *fiveDollarImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Dollar05" ofType:@"jpg"]];
    [fiveDollarButton setBackgroundImage:fiveDollarImage forState:UIControlStateNormal];
    [fiveDollarButton setTag:5];

    UIImage *oneDollarImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Dollar01" ofType:@"jpg"]];
    [oneDollarButton setBackgroundImage:oneDollarImage forState:UIControlStateNormal];
    [oneDollarButton setTag:1];
    
    [slider setMinimumValue:0.0];
    [slider setMaximumValue:20.0];
    [slider setContinuous:YES];
    
    NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"correct" withExtension:@"wav"];
    if (VERBOSE) NSLog(@"%@", soundURL);
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundFileObject);

    [self playAgain:nil];
    
}

- (void) dealloc
{
    AudioServicesDisposeSystemSoundID(soundFileObject);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    AudioServicesDisposeSystemSoundID(soundFileObject);
}

- (IBAction)buttonPushed:(id)sender
{
    WBAnswerButton *answerButton = (WBAnswerButton *)sender;
    
    if (VERBOSE) NSLog(@"Button pressed: $%d", [answerButton tag]);
    
    if (answerButton == correctButton)
        [self answerCorrect];
    else
        [self answerIncorrect:answerButton];
}

- (IBAction)playAgain:(id)sender
{
    NSArray *items = [[WBItemStore sharedStore] allItems];
    WBItem *newItem = currentItem;
    while (newItem == currentItem)
        newItem = [items objectAtIndex: arc4random() % [items count]];
    [currentItem setCost];
    [self setCurrentItem:newItem];
    if (VERBOSE) NSLog(@"Current item is %@: $%f", [currentItem name], [currentItem cost]);
    
    if ([currentItem cost] < 1.005)
        [self setCorrectButton:oneDollarButton];
    else if ([currentItem cost] < 5.005)
        [self setCorrectButton:fiveDollarButton];
    else if ([currentItem cost] < 10.005)
        [self setCorrectButton:tenDollarButton];
    else
        [self setCorrectButton:twentyDollarButton];
    
    UIImage *img = [[WBImageStore sharedStore] imageForKey:[currentItem imageKey]];
    [imageView setImage:img];
    [nameLabel setText:[currentItem name]];
    [costLabel setText:[NSString stringWithFormat:@"$%.2f", [currentItem cost]]];
    [msgLabel setText:@"Which bill should you use?"];
    
    [slider setValue:[slider minimumValue]];
    [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    [oneDollarButton setAlreadyGuessedWrong:NO];
    [fiveDollarButton setAlreadyGuessedWrong:NO];
    [tenDollarButton setAlreadyGuessedWrong:NO];
    [twentyDollarButton setAlreadyGuessedWrong:NO];
    
    [twentyDollarButton setEnabled:YES];
    [tenDollarButton setEnabled:YES];
    [fiveDollarButton setEnabled:YES];
    [oneDollarButton setEnabled:YES];
    [slider setEnabled:YES];
    [playAgainButton setEnabled:NO];
}

- (IBAction)showInstructions:(id)sender
{
    InstructionsViewController *instructions = [[InstructionsViewController alloc] init];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        instructionsPopover = [[UIPopoverController alloc] initWithContentViewController:instructions];
        UIButton *button = (UIButton *)sender;
        [instructionsPopover presentPopoverFromRect:button.bounds
                                             inView:button
                           permittedArrowDirections:UIPopoverArrowDirectionAny
                                           animated:YES];
    }
    else
    {
        [self presentViewController:instructions animated:YES completion:nil];
    }
}

- (void)answerCorrect
{
    if (VERBOSE) NSLog(@"Answer correct!");
    [twentyDollarButton setEnabled:NO];
    [tenDollarButton setEnabled:NO];
    [fiveDollarButton setEnabled:NO];
    [oneDollarButton setEnabled:NO];
    [slider setEnabled:NO];
    [playAgainButton setEnabled:YES];
    [msgLabel setText:@"Correct!"];
    [self playCorrectSound];
}

- (void)answerIncorrect:(WBAnswerButton *)answerButton
{
    if (VERBOSE) NSLog(@"Answer incorrect :(");
    if ([answerButton tag] > [correctButton tag])
        [msgLabel setText:@"You can use a smaller bill, if you have it."];
    else
        [msgLabel setText:@"That's not enough money. Try a bigger bill"];
    [answerButton setEnabled:NO];
    [answerButton setAlreadyGuessedWrong:YES];
}

- (void)sliderChanged:(id)sender
{
    if (VERBOSE) NSLog(@"Slider Value: %.3f", [slider value]);
    
    if (fabs([slider value] - [correctButton tag]) < 0.50)
    {
        [oneDollarButton setEnabled:NO];
        [fiveDollarButton setEnabled:NO];
        [tenDollarButton setEnabled:NO];
        [twentyDollarButton setEnabled:NO];
        [correctButton setEnabled:YES];
        
        [msgLabel setText:@"Do you see which bill to use?"];
    }
    else
    {
        if (![oneDollarButton alreadyGuessedWrong])
            [oneDollarButton setEnabled:YES];
        if (![fiveDollarButton alreadyGuessedWrong])
            [fiveDollarButton setEnabled:YES];
        if (![tenDollarButton alreadyGuessedWrong])
            [tenDollarButton setEnabled:YES];
        if (![twentyDollarButton alreadyGuessedWrong])
            [twentyDollarButton setEnabled:YES];
        
        [msgLabel setText:@""];
    }
}

- (void)playCorrectSound
{
    if (VERBOSE) NSLog(@"Playing sound.");
    AudioServicesPlaySystemSound(soundFileObject);
}

@end
