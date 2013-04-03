//
//  MainMenuLayer.m
//  JokerJumper
//
//  Created by Sun on 2/17/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MainMenuLayer.h"
#import "CCControlButton.h"
#import "CCBReader.h"
#import "GameScene.h"

#define PLAY_BUTTON_TAG 1
#define OPTIONS_BUTTON_TAG 2
#define ABOUT_BUTTON_TAG 3

@implementation MainMenuLayer

-(void)newButtonPressed:(id)sender {
    CCMenuItemImage *item = (CCMenuItemImage*) sender;
    switch (item.tag) {
        case PLAY_BUTTON_TAG:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"LevelScene.ccbi"]]];
            break;
        case OPTIONS_BUTTON_TAG:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"OptionsScene.ccbi"]]];
            break;
        case ABOUT_BUTTON_TAG:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"AboutScene.ccbi"]]];
            break;
    }
}

-(void)buttonPressed:(id)sender {
    CCControlButton *button = (CCControlButton*) sender;
    switch (button.tag) {
        case PLAY_BUTTON_TAG:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"LevelScene.ccbi"]]];
            break;
        case OPTIONS_BUTTON_TAG:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"OptionsScene.ccbi"]]];
            break;
        case ABOUT_BUTTON_TAG:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"AboutScene.ccbi"]]];
            break;
    }
}

@end