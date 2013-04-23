//
//  GameOptionsScene.m
//  JokerJumper
//
//  Created by Sun on 4/23/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

int optionGameLevel;

#import "Constants.h"
#import "GameOptionsScene.h"
#import "GameScene.h"
#import "MainMenuScene.h"

@implementation GameOptionsScene

+(CCScene *) sceneWithLevel:(int)level Coin:(int)coin Distance:(int)distance {
    optionGameLevel = level;
    
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    GameOptionsScene *layer = [GameOptionsScene node];
    [scene addChild:layer z:3];
    
	return scene;
}

-(id) init {
    if ((self = [ super init])) {
		
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        // Create a label for display purposes
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"You Lose!" fontName:@"Marker Felt" fontSize:45];
        label.color = ccWHITE;
		label.position = CGPointMake(winSize.width/2,winSize.height/2+200);
		[self addChild:label z:0];
                
        // Create Replay Button
        CCMenuItem *buttonReplay = [CCMenuItemImage itemWithNormalImage:@"button_play_sel.png" selectedImage:@"button_play_sel.png" target:self selector:@selector(buttonReplayAction:)];
        
        // Create Mainmenu Button
        CCMenuItem *buttonMain = [CCMenuItemImage itemWithNormalImage:@"button_about_sel.png" selectedImage:@"button_about_sel.png" target:self selector:@selector(buttonMainAction:)];
        
        CCMenu *Menu = [CCMenu menuWithItems:buttonReplay, buttonMain, nil];
        Menu.position=ccp(winSize.width/2, winSize.height/2 - 100);
        
        [Menu alignItemsVertically];
        [self addChild:Menu];
    }
    return self;
}

- (void)buttonReplayAction:(id)sender {
    switch (optionGameLevel) {
        case 1:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene sceneWithState:GAME_STATE_ONE]]];
            break;
        case 2:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene sceneWithState:GAME_STATE_TWO]]];
            break;
        case 3:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene sceneWithState:GAME_STATE_TWO]]];
            break;
        default:
            break;
    }
}

- (void)buttonMainAction:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainMenuScene scene]]];
}

@end
