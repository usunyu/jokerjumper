//
//  GameOverScene.m
//  JokerJumper
//
//  Created by Sun on 4/16/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameWinScene.h"
#import "GameScene.h"
#import "BackgroundLayer.h"
#import "Constants.h"

int stageLevel;
int coinNum;
int distanceNum;

@implementation GameWinScene

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    GameWinScene *layer = [GameWinScene node];
    [scene addChild:layer z:3];
    
	return scene;
}

+(CCScene *) sceneWithLevel:(int)level Coin:(int)coin Distance:(int)distance {
    stageLevel = level;
    coinNum = coin;
    distanceNum = distance;
    
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    GameWinScene *layer = [GameWinScene node];
    [scene addChild:layer z:3];
    
	return scene;
}

-(id) init {
    if( (self=[super init] )) {
		
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        // Create a label for display purposes
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"You Win!" fontName:@"Marker Felt" fontSize:45];
        label.color = ccWHITE;
		label.position = CGPointMake(winSize.width/2,winSize.height/2+200);
		[self addChild:label z:0];
        
        NSString *coinStr = [NSString stringWithFormat:@"Coin:%2d", coinNum];
        
        CCLabelTTF *labelCoin = [CCLabelTTF labelWithString:coinStr fontName:@"Marker Felt" fontSize:40];
        labelCoin.color = ccWHITE;
		labelCoin.position = CGPointMake(winSize.width/2 - 200,winSize.height/2+100);
		[self addChild:labelCoin z:0];
        
        NSString *disStr = [NSString stringWithFormat:@"Distance:%2d", distanceNum];
        
        CCLabelTTF *labelDistance = [CCLabelTTF labelWithString:disStr fontName:@"Marker Felt" fontSize:40];
        labelDistance.color = ccWHITE;
		labelDistance.position = CGPointMake(winSize.width/2 + 200,winSize.height/2+100);
		[self addChild:labelDistance z:0];

        
        // Create Replay Button
        CCMenuItem *buttonReplay = [CCMenuItemImage itemWithNormalImage:@"button_play_sel.png" selectedImage:@"button_play_sel.png" target:self selector:@selector(buttonReplayAction:)];
        
        // Create Next Button
        CCMenuItem *buttonNext = [CCMenuItemImage itemWithNormalImage:@"button_about_sel.png" selectedImage:@"button_about_sel.png" target:self selector:@selector(buttonNextAction:)];
        
        CCMenu *Menu = [CCMenu menuWithItems:buttonReplay, buttonNext, nil];
        Menu.position=ccp(winSize.width/2, winSize.height/2 - 100);
        
        [Menu alignItemsVertically];
        [self addChild:Menu];
    }
    return self;
}

- (void)buttonReplayAction:(id)sender {
    switch (stageLevel) {
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

- (void)buttonNextAction:(id)sender {
    switch (stageLevel) {
        case 1:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene sceneWithState:GAME_STATE_TWO]]];
            break;
        case 2:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene sceneWithState:GAME_STATE_THREE]]];
            break;
        case 3:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene sceneWithState:GAME_STATE_ONE]]];
            break;
        default:
            break;
    }
}

@end
