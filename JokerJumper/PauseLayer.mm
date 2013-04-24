//
//  PauseLayer.m
//  JokerJumper
//
//  Created by Sun on 3/31/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "PauseLayer.h"
#import "GameScene.h"
#import "Constants.h"
#import "CCBReader.h"
#import "SimpleAudioEngine.h"
#import "MainMenuScene.h"

int buttonSelected;

@implementation PauseLayer

-(id) init
{
	if ((self = [super initWithColor:ccc4(139, 137, 137, 200)]))
	{
        self.tag=PAUSE_LAYER_TAG;
        buttonSelected = 0;
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game Paused!" fontName:@"Marker Felt" fontSize:65];
		label.color = ccWHITE;
		label.position = CGPointMake(screenSize.width/2,screenSize.height/2+200);
		//label.anchorPoint = CGPointMake(0.5f, 1);
		[self addChild:label z:0 tag:1000];
        
        // Resume Button
        resume = [CCMenuItemImage itemWithNormalImage:@"btn_transparent.png" selectedImage:@"btn_transparent.png" target:self selector:@selector(resumeButtonSelected)];
        labelResume = [CCLabelTTF labelWithString:@"Resume" fontName:@"Marker Felt" fontSize:55];
        labelResume.color = ccBLACK;
        labelResume.position = ccp(510, 470);
        [self addChild:labelResume z:1];
        
        // Restart Button
        restart = [CCMenuItemImage itemWithNormalImage:@"btn_transparent.png" selectedImage:@"btn_transparent.png" target:self selector:@selector(restartButtonSelected)];
        restartResume = [CCLabelTTF labelWithString:@"Restart" fontName:@"Marker Felt" fontSize:55];
        restartResume.color = ccBLACK;
        restartResume.position = ccp(510, 385);
        [self addChild:restartResume z:1];
        
        main = [CCMenuItemImage itemWithNormalImage:@"btn_transparent.png" selectedImage:@"btn_transparent.png" target:self selector:@selector(mainButtonSelected)];
        mainResume = [CCLabelTTF labelWithString:@"Menu" fontName:@"Marker Felt" fontSize:55];
        mainResume.color = ccBLACK;
        mainResume.position = ccp(515, 300);
        [self addChild:mainResume z:1];
        
        CCMenu *menu = [CCMenu menuWithItems:resume, restart, main, nil];
        menu.position =  ccp( screenSize.width /2 , screenSize.height/2);
        [menu alignItemsVertically];
        [self addChild:menu];
        [self schedule:@selector(update:) interval:0.01f];
        
    }
	return self;
}

- (void)updateMainLabelWithText:(NSString *)text {
    CCLabelTTF *label = (CCLabelTTF *)[self getChildByTag:1000];
    [label setString:text];
}

- (void)update:(ccTime) dt
{
    switch (buttonSelected) {
        case 1:
            resume.scale += 0.01;
            labelResume.scale += 0.01;
            break;
        case 2:
            restart.scale += 0.01;
            restartResume.scale += 0.01;
            break;
        case 3:
            main.scale += 0.01;
            mainResume.scale += 0.01;
            break;

        default:
            break;
    }
}


- (void)mainButtonSelected
{
    buttonSelected = 3;
    [self schedule:@selector(update:) interval:0.01f];
    CCLOG(@"Main Menu button selected, popping...");
    [[GameScene sharedGameScene] setShowingPausedMenu:NO];
    [[CCDirector sharedDirector] resume];
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainMenuScene scene]]];
//    [[CCDirector sharedDirector] replaceScene:[CCTransitionSplitRows transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"MainMenuScene.ccbi"]]];
    [[GameScene sharedGameScene] removeChildByTag:PAUSE_LAYER_TAG cleanup:YES];
    
}

-(void)resumeButtonSelected
{
    buttonSelected = 1;
    [self schedule:@selector(update:) interval:0.01f];
    [[GameScene sharedGameScene] setShowingPausedMenu:NO];
    [[CCDirector sharedDirector] resume];
    [[GameScene sharedGameScene] removeChildByTag:PAUSE_LAYER_TAG cleanup:YES];
    
    
}

- (void)restartButtonSelected
{
    buttonSelected = 2;
    [self schedule:@selector(update:) interval:0.01f];
    [[GameScene sharedGameScene] setShowingPausedMenu:NO];
    [[CCDirector sharedDirector] resume];
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
//    [[CCDirector sharedDirector] replaceScene:[CCTransitionSplitRows transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"GameOver.ccbi"]]];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainMenuScene scene]]];
    [[GameScene sharedGameScene] removeChildByTag:PAUSE_LAYER_TAG cleanup:YES];

}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}


@end
