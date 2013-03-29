//
//  GameOverLayer.m
//  JokerJumper
//
//  Created by Sun on 3/13/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameOverLayer.h"
#import "CCControlButton.h"
#import "CCBReader.h"
#import "GameScene.h"

#define MAIN_MENU_BUTTON_TAG 1
#define PLAY_AGAIN_BUTTON_TAG 2

@implementation GameOverLayer

-(void)buttonPressed:(id)sender {
    CCControlButton *button = (CCControlButton*) sender;
    switch (button.tag) {
        case MAIN_MENU_BUTTON_TAG:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipY transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"MainMenuScene.ccbi"]]];
            break;
            
        case PLAY_AGAIN_BUTTON_TAG:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[GameScene scene]]];
//            [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeUp transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"GameScene.ccbi"]]];
            break;
    }
}

@end
