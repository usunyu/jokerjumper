//
//  OptionsLayer.m
//  JokerJumper
//
//  Created by Sun on 2/17/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "OptionsLayer.h"
#import "CCBReader.h"
#import "CCControlButton.h"

#define DIFFICULTY_EASY_BUTTON_TAG 1
#define DIFFICULTY_MEDIUM_BUTTON_TAG 2
#define DIFFICULTY_HARD_BUTTON_TAG 3

@implementation OptionsLayer

-(void)backButtonPressed:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"MainMenuScene.ccbi"]]];
}

-(void)difficultyButtonPressed:(id)sender {
    CCControlButton *button = (CCControlButton*) sender;
    NSString *difficultyLevel = @"Hard";
    if (button.tag == DIFFICULTY_EASY_BUTTON_TAG) {
        difficultyLevel = @"Easy";
    } else if(button.tag == DIFFICULTY_MEDIUM_BUTTON_TAG) {
        difficultyLevel = @"Medium";
    }
    NSLog(@"Difficulty is set to %@", difficultyLevel);
}

@end
