//
//  PauseLayer.m
//  JokerJumper
//
//  Created by Sun on 3/31/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "PauseLayer.h"


@implementation PauseLayer

-(id) init
{
	if ((self = [super initWithColor:ccc4(139, 137, 137, 200)]))
	{
        self.tag=PAUSE_LAYER_TAG;
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game Paused!" fontName:@"Marker Felt" fontSize:45];
		label.color = ccWHITE;
		label.position = CGPointMake(screenSize.width/2,screenSize.height/2+200);
		//label.anchorPoint = CGPointMake(0.5f, 1);
		[self addChild:label z:0 tag:1000];
        
        CCMenuItemImage *resume = [CCMenuItemImage itemWithNormalImage:@"button_play_sel.png" selectedImage:@"button_play_sel.png" target:self selector:@selector(resumeButtonSelected)];
        CCMenuItemImage *restart = [CCMenuItemImage itemWithNormalImage:@"button_option_sel.png" selectedImage:@"button_play_sel.png" target:self selector:@selector(restartButtonSelected)];
        CCMenuItemImage *main = [CCMenuItemImage itemWithNormalImage:@"button_about_sel.png" selectedImage:@"button_play_sel.png" target:self selector:@selector(mainButtonSelected)];
        
        CCMenu *menu = [CCMenu menuWithItems:resume, restart, main, nil];
        menu.position =  ccp( screenSize.width /2 , screenSize.height/2);
        [menu alignItemsVertically];
        [self addChild:menu];
        
    }
	return self;
}

- (void)updateMainLabelWithText:(NSString *)text {
    CCLabelTTF *label = (CCLabelTTF *)[self getChildByTag:1000];
    [label setString:text];
}


- (void)mainButtonSelected
{
    CCLOG(@"Main Menu button selected, popping...");
    [[GameScene sharedGameScene] setShowingPausedMenu:NO];
    [[CCDirector sharedDirector] resume];
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSplitRows transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"MainMenuScene.ccbi"]]];
    [[GameScene sharedGameScene] removeChildByTag:PAUSE_LAYER_TAG cleanup:YES];
    
}

-(void)resumeButtonSelected
{
    [[GameScene sharedGameScene] setShowingPausedMenu:NO];
    [[CCDirector sharedDirector] resume];
    [[GameScene sharedGameScene] removeChildByTag:PAUSE_LAYER_TAG cleanup:YES];
    
    
}

- (void)restartButtonSelected
{
    CCLOG(@"Main Menu button selected, popping...");
    [[GameScene sharedGameScene] setShowingPausedMenu:NO];
    [[CCDirector sharedDirector] resume];
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSplitRows transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"GameOver.ccbi"]]];
    [[GameScene sharedGameScene] removeChildByTag:PAUSE_LAYER_TAG cleanup:YES];

}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}


@end
