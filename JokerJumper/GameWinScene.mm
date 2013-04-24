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

int currentCoinNum2;
int currentDistanceNum2;

BOOL coinFinish2;
BOOL distanceFinish2;

CCSpriteBatchNode* winCharacterBatchNode;
CCSprite* winJoker;


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
    if ((self = [ super init])) {
		
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"all_character_default.plist"];
        winCharacterBatchNode=[CCSpriteBatchNode batchNodeWithFile:@"all_character_default.png"];
        
        [self addChild:winCharacterBatchNode z:1];
        
        winJoker = [CCSprite spriteWithSpriteFrameName:@"joker1.png"];
        winJoker.position = ccp(80, 255);
        
        NSMutableArray *jokerrunAnimFrames = [NSMutableArray array];
        for(int i = 1; i <= 14; ++i) {
            [jokerrunAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"joker%d.png", i]]];
        }
        
        CCAnimation *jokerRunAnimation = [CCAnimation animationWithSpriteFrames:jokerrunAnimFrames delay:0.09f];
        CCAction *jokerRunAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: jokerRunAnimation]];
        jokerRunAction.tag = jokerRunActionTag;
        [winJoker runAction:jokerRunAction];
        [winCharacterBatchNode addChild:winJoker];
        CCFiniteTimeAction *winMoveAction = [CCMoveTo actionWithDuration:6.0f position:ccp(winSize.width - 100, 255)];
        winJoker.scale=1.5;
        [winJoker runAction:winMoveAction];
        
        NSString *coinStr = [NSString stringWithFormat:@"%2d", 0];
        labelCoin = [CCLabelTTF labelWithString:coinStr fontName:@"Marker Felt" fontSize:40];
        labelCoin.color = ccRED;
		labelCoin.position = CGPointMake(500, 540);
		[self addChild:labelCoin z:3];
        
        NSString *disStr = [NSString stringWithFormat:@"%2d", 0];
        
        labelDistance = [CCLabelTTF labelWithString:disStr fontName:@"Marker Felt" fontSize:40];
        labelDistance.color = ccRED;
		labelDistance.position = CGPointMake(500, 455);
		[self addChild:labelDistance z:3];
        
        switch (stageLevel) {
            case GAME_STATE_ONE:
                button = [CCMenuItemImage itemWithNormalImage:@"level1end.png" selectedImage:@"level1end.png" target:self selector:@selector(buttonNextAction:)];
                break;
            case GAME_STATE_TWO:
                button = [CCMenuItemImage itemWithNormalImage:@"level2end.png" selectedImage:@"level2end.png" target:self selector:@selector(buttonNextAction:)];
                break;
            case GAME_STATE_THREE:
                button = [CCMenuItemImage itemWithNormalImage:@"level3end.png" selectedImage:@"level3end.png" target:self selector:@selector(buttonNextAction:)];
                break;

            default:
                break;
        }
        Menu = [CCMenu menuWithItems:button, nil];
        Menu.position=ccp(winSize.width/2, winSize.height/2);
        [Menu alignItemsHorizontally];
        [self addChild:Menu];
        
        /*
        // Create a label for display purposes
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"You Win!" fontName:@"Marker Felt" fontSize:60];
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
         */
        [self schedule:@selector(update:) interval:0.01f];
    }
    return self;
}


- (void)update:(ccTime) dt
{
        if(currentCoinNum2 < coinNum) {
            currentCoinNum2++;
            NSString *coinStr = [NSString stringWithFormat:@"%2d", currentCoinNum2];
            [labelCoin setString:coinStr];
        }
        else
            coinFinish2 = true;
        if(currentDistanceNum2 < distanceNum) {
            currentDistanceNum2++;
            NSString *disStr = [NSString stringWithFormat:@"%2d", currentDistanceNum2];
            [labelDistance setString:disStr];
        }
        else
            distanceFinish2 = true;
        
        if (coinFinish2) {
            if(labelCoin.scale <= 1.3)
                labelCoin.scale += 0.01;
        }
        
        if (distanceFinish2) {
            if(labelDistance.scale <= 1.3)
                labelDistance.scale += 0.01;
        }
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
