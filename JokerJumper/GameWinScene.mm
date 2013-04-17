//
//  GameOverScene.m
//  JokerJumper
//
//  Created by Sun on 4/16/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameWinScene.h"
#import "BackgroundLayer.h"

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
        
        // Create Replay Button
        CCMenuItem *buttonReplay = [CCMenuItemImage itemWithNormalImage:@"button_play_sel.png" selectedImage:@"button_play_sel.png" target:self selector:@selector(buttonReplayAction:)];
        
        // Create Next Button
        CCMenuItem *buttonNext = [CCMenuItemImage itemWithNormalImage:@"button_about_sel.png" selectedImage:@"button_about_sel.png" target:self selector:@selector(buttonNextAction:)];
        
        CCMenu *Menu = [CCMenu menuWithItems:buttonReplay, buttonNext, nil];
        Menu.position=ccp(winSize.width/2, winSize.height/2);
        
        [Menu alignItemsVertically];
        [self addChild:Menu];
    }
    return self;
}

@end
