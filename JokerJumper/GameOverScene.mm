//
//  GameOverScene.m
//  JokerJumper
//
//  Created by Sun on 4/17/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameOverScene.h"
#import "GameOverLayer.h"
#import "GameScene.h"
#import "Constants.h"
#import "MainMenuScene.h"

int stageLevel2;
static int coinNum2;
static int distanceNum2;

int currentCoinNum;
int currentDistanceNum;

int timeSlap;
BOOL coinFinish;
BOOL distanceFinish;

BOOL replaySelected;

BOOL mainSelected;

@implementation GameOverScene

//+(CCScene *) scene
//{
//	// 'scene' is an autorelease object.
//	CCScene *scene = [CCScene node];
//    
//    GameOverScene *layer = [GameOverScene node];
//    [scene addChild:layer z:3];
//    
//	// 'layer' is an autorelease object.
//	GameOverLayer *gameOverLayer = [GameOverLayer node];
//	// add layer as a child to scene
//	[scene addChild: gameOverLayer z:1];
//    
//	// return the scene
//	return scene;
//}

+(CCScene *) sceneWithLevel:(int)level Coin:(int)coin Distance:(int)distance {
    stageLevel2 = level;
    coinNum2 = coin;
    distanceNum2 = distance;
    
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    GameOverScene *layer = [GameOverScene node];
    [scene addChild:layer z:3];
    
	return scene;
}

-(id) init {
    if ((self = [ super init])) {
        timeSlap = 0;
        distanceFinish = false;
        coinFinish = false;
        currentCoinNum = 0;
        currentDistanceNum = 0;
        
        replaySelected = false;
        labelReplay.scale = 1;
        buttonReplay.scale = 1;
        
        mainSelected = false;
        buttonMain.scale = 1;
        labelMain.scale = 1;

        CGSize winSize = [[CCDirector sharedDirector] winSize];
        // Create a label for display purposes
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"You Lose!" fontName:@"Marker Felt" fontSize:60];
        label.color = ccWHITE;
		label.position = CGPointMake(winSize.width/2,winSize.height/2+200);
		[self addChild:label z:0];
        
        NSString *coinStr = [NSString stringWithFormat:@"Coin:%2d", 0];
        
        labelCoin = [CCLabelTTF labelWithString:coinStr fontName:@"Marker Felt" fontSize:40];
        labelCoin.color = ccWHITE;
		labelCoin.position = CGPointMake(winSize.width/2 - 200,winSize.height/2+100);
		[self addChild:labelCoin z:0];
        
        NSString *disStr = [NSString stringWithFormat:@"Distance:%2d", 0];
        
        labelDistance = [CCLabelTTF labelWithString:disStr fontName:@"Marker Felt" fontSize:40];
        labelDistance.color = ccWHITE;
		labelDistance.position = CGPointMake(winSize.width/2 + 200,winSize.height/2+100);
		[self addChild:labelDistance z:0];
        
        // Create Replay Button
        buttonReplay = [CCMenuItemImage itemWithNormalImage:@"btn_transparent.png" selectedImage:@"btn_transparent.png" target:self selector:@selector(buttonReplayAction:)];
        labelReplay = [CCLabelTTF labelWithString:@"Replay" fontName:@"Marker Felt" fontSize:55];
        labelReplay.color = ccBLACK;
        labelReplay.position = ccp(510, 330);
        [self addChild:labelReplay z:1];
        
        // Create Mainmenu Button
        buttonMain = [CCMenuItemImage itemWithNormalImage:@"btn_transparent.png" selectedImage:@"btn_transparent.png" target:self selector:@selector(buttonMainAction:)];
        labelMain = [CCLabelTTF labelWithString:@"Menu" fontName:@"Marker Felt" fontSize:55];
        labelMain.color = ccBLACK;
        labelMain.position = ccp(510, 243);
        [self addChild:labelMain z:1];
        
        CCMenu *Menu = [CCMenu menuWithItems:buttonReplay, buttonMain, nil];
        Menu.position=ccp(winSize.width/2, winSize.height/2 - 100);
        
        [Menu alignItemsVertically];
        [self addChild:Menu];
        [self schedule:@selector(update:) interval:0.01f];
    }
    return self;
}

- (void)update:(ccTime) dt
{
        timeSlap++;
        if(timeSlap >= 10) {
            if(currentCoinNum < coinNum2) {
                currentCoinNum++;
                NSString *coinStr = [NSString stringWithFormat:@"Coin:%2d", currentCoinNum];
                [labelCoin setString:coinStr];
            }
            else
                coinFinish = true;
            if(currentDistanceNum < distanceNum2) {
                currentDistanceNum++;
                NSString *disStr = [NSString stringWithFormat:@"Distance:%2d", currentDistanceNum];
                [labelDistance setString:disStr];
            }
            else
                distanceFinish = true;
            
            if (coinFinish) {
                if(labelCoin.scale <= 1.5)
                    labelCoin.scale += 0.01;
            }
            
            if (distanceFinish) {
                if(labelDistance.scale <= 1.5)
                    labelDistance.scale += 0.01;
            }
        }
    
    if(replaySelected) {
        if(labelReplay.scale <= 1.2) {
            labelReplay.scale += 0.01;
            buttonReplay.scale += 0.01;
        }
    }
    
    if(mainSelected) {
        if(labelReplay.scale <= 1.2) {
            labelMain.scale += 0.01;
            buttonMain.scale += 0.01;
        }
    }

}


- (void)buttonReplayAction:(id)sender {
    replaySelected = true;
    switch (stageLevel2) {
        case 1:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene sceneWithState:GAME_STATE_ONE]]];
            break;
        case 2:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene sceneWithState:GAME_STATE_TWO]]];
            break;
        case 3:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene sceneWithState:GAME_STATE_THREE]]];
            break;
        default:
            break;
    }
}

- (void)buttonMainAction:(id)sender {
    mainSelected = true;
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainMenuScene scene]]];

}

@end
