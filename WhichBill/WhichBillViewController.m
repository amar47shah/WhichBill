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

@implementation WhichBillViewController

static BOOL const verbose = 0;

@synthesize currentItem, correctButton;
@synthesize soundCorrect, soundIncorrect, soundStart;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    soundsLoaded = NO;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSArray *items = [[WBItemStore sharedStore] allItems];
    
    for (WBItem *item in items)
    {
        [self log:[NSString stringWithFormat:@"%@", [item name]]];
        [self log:[NSString stringWithFormat:@"%f", [item cost]]];
        [self log:[NSString stringWithFormat:@"%@", [item imageKey]]];
        if ([[WBImageStore sharedStore] imageForKey:[item imageKey]])
            [self log:@"Image Found."];
        else
            [self log:@"Image Not Found."];
    }
    
    if (!soundsLoaded)
    {
        NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"correct" withExtension:@"wav"];
        [self log:[NSString stringWithFormat:@"Correct Sound: %@", soundURL]];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundCorrect);
    
        soundURL = [[NSBundle mainBundle] URLForResource:@"incorrect" withExtension:@"wav"];
        [self log:[NSString stringWithFormat:@"Incorrect Sound: %@", soundURL]];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundIncorrect);
    
        soundURL = [[NSBundle mainBundle] URLForResource:@"start" withExtension:@"wav"];
        [self log:[NSString stringWithFormat:@"Start Sound: %@", soundURL]];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundStart);
        
        soundsLoaded = YES;
    }
        
    [self playAgain:nil];
}

- (void)dealloc
{
    if (soundsLoaded)
    {
        AudioServicesDisposeSystemSoundID(soundCorrect);
        AudioServicesDisposeSystemSoundID(soundIncorrect);
        AudioServicesDisposeSystemSoundID(soundStart);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if (soundsLoaded)
    {
        AudioServicesDisposeSystemSoundID(soundCorrect);
        AudioServicesDisposeSystemSoundID(soundIncorrect);
        AudioServicesDisposeSystemSoundID(soundStart);

        soundsLoaded = NO;
    }
}

- (IBAction)buttonPushed:(id)sender
{
    WBAnswerButton *answerButton = (WBAnswerButton *)sender;
    
    [self log:[NSString stringWithFormat:@"Button pressed: $%d", [answerButton tag]]];
    
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
    [newItem setCost];
    [self setCurrentItem:newItem];
    [self log:[NSString stringWithFormat:@"Current item is %@: $%f", [currentItem name], [currentItem cost]]];
    
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
    
    [self playSound:@"start"];
}

- (IBAction)showInstructions:(id)sender
{
    [self log:@"Show instructions"];
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
    
    [self playSound:@"start"];
}

- (void)answerCorrect
{
    [self log:@"Answer correct!"];
    
    [twentyDollarButton setEnabled:NO];
    [tenDollarButton setEnabled:NO];
    [fiveDollarButton setEnabled:NO];
    [oneDollarButton setEnabled:NO];
    [slider setEnabled:NO];
    [playAgainButton setEnabled:YES];
    [msgLabel setText:@"Correct!"];
    
    [self playSound:@"correct"];
}

- (void)answerIncorrect:(WBAnswerButton *)answerButton
{
    [self log:@"Answer incorrect :("];
    
    if ([answerButton tag] > [correctButton tag])
        [msgLabel setText:@"You can use a smaller bill,\nif you have it."];
    else
        [msgLabel setText:@"That's not enough money.\nTry a bigger bill"];
    [answerButton setEnabled:NO];
    [answerButton setAlreadyGuessedWrong:YES];
    
    [self playSound:@"incorrect"];
}

- (void)sliderChanged:(id)sender
{
    [self log:[NSString stringWithFormat:@"Slider Value: %.3f", [slider value]]];
    
    if (fabs([slider value] - [correctButton tag]) < 0.50)
    {
        [oneDollarButton setEnabled:NO];
        [fiveDollarButton setEnabled:NO];
        [tenDollarButton setEnabled:NO];
        [twentyDollarButton setEnabled:NO];
        [correctButton setEnabled:YES];
        
        [msgLabel setText:@"Do you see which bill\nto use?"];
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

- (void)log:(NSString *)msg
{
    if (verbose) NSLog (@"%@", msg);
}

- (void)playSound:(NSString *)snd
{
    if (soundsLoaded)
    {
        if ([snd isEqualToString:@"start"])
        {
            [self log:@"Play start sound."];
            AudioServicesPlaySystemSound(soundStart);
        }
        else if ([snd isEqualToString:@"correct"])
        {
            [self log:@"Play correct sound."];
            AudioServicesPlaySystemSound(soundCorrect);
        }
        else if ([snd isEqualToString:@"incorrect"])
        {
            [self log:@"Play incorrect sound."];
            AudioServicesPlaySystemSound(soundIncorrect);
        }
    }
}

@end
