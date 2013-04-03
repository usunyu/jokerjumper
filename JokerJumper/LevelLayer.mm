//
//  LevelLayer.m
//  JokerJumper
//
//  Created by Sun on 3/31/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LevelLayer.h"
#import "CCControlButton.h"
#import "CCBReader.h"
#import "GameScene.h"
#import "Constants.h"

@implementation LevelLayer

-(void)backButtonPressed:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"MainMenuScene.ccbi"]]];
}

-(void)buttonPressed:(id)sender {
    CCControlButton *button = (CCControlButton*) sender;
    switch (button.tag) {
        case GAME_STATE_ONE:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[GameScene sceneWithState:GAME_STATE_ONE]]];
            break;
        case GAME_STATE_TWO:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[GameScene sceneWithState:GAME_STATE_TWO]]];
            break;
        case GAME_STATE_THREE:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[GameScene sceneWithState:GAME_STATE_THREE]]];
            break;
    }
}

@end